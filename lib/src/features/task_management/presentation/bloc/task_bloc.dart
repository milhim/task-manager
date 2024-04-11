import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/src/core/constants/keys.dart';
import 'package:task_manager/src/core/constants/strings.dart';
import 'package:task_manager/src/core/utils/managers/database/hive_service.dart';
import 'package:task_manager/src/features/injection.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/domain/use_cases/create_task_use_case.dart';
import 'package:task_manager/src/features/task_management/domain/use_cases/delete_task_use_case.dart';
import 'package:task_manager/src/features/task_management/domain/use_cases/get_task_use_case.dart';
import 'package:task_manager/src/features/task_management/domain/use_cases/get_tasks_use_case.dart';
import 'package:task_manager/src/features/task_management/domain/use_cases/update_task_use_case.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase _getTasksUseCase;
  final GetTaskUseCase _getTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final HiveService _hiveService;
  int page = 1;

  TaskBloc(
      {required GetTasksUseCase getTasksUseCase,
      required GetTaskUseCase getTaskUseCase,
      required UpdateTaskUseCase updateTaskUseCase,
      required CreateTaskUseCase createTaskUseCase,
      required DeleteTaskUseCase deleteTaskUseCase,
      required HiveService hiveService})
      : _getTasksUseCase = getTasksUseCase,
        _getTaskUseCase = getTaskUseCase,
        _updateTaskUseCase = updateTaskUseCase,
        _createTaskUseCase = createTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        _hiveService = hiveService,
        super(TaskInitial()) {
    on<TaskEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadTasks>((event, emit) async {
      if (state is TaskLoading) {
        return;
      }
      final currentState = state;
      var oldTasks = <TaskEntity>[];
      if (currentState is TasksLoaded) {
        oldTasks = currentState.tasks;
      }
      emit(TaskLoading(oldTasks: oldTasks, isFirstFetch: page == 1));
      final result = await _getTasksUseCase(GetTasksParams(page: page));

      await result.fold((l) async {
        if (l.error == NO_INTERNET_CONNECTION_ERROR_MESSAGE) {
          final localTasks = await _hiveService.getBoxes<TaskEntity>(kTaskKey) as List<TaskEntity>;
          emit(TasksLoaded(localTasks));

          return;
        }
        emit(TaskError('Failed to load tasks.'));
      }, (newTasks) async {
        if (page == 1) {
          emit(TasksLoaded(newTasks));
          await _hiveService.addBoxes<TaskEntity>(newTasks, kTaskKey);

          page++;
        } else {
          page++;
          final tasks = (state as TaskLoading).oldTasks;
          tasks!.addAll(newTasks);
          emit(TasksLoaded(tasks));
          await _hiveService.addBoxes<TaskEntity>(tasks, kTaskKey);
        }
      });
    });
    on<LoadTask>((event, emit) async {
      page = 0;
      emit(TaskLoading());
      final result = await _getTaskUseCase(Params(id: int.parse(event.taskId)));
      result.fold((l) => emit(TaskError('Failed to load task.')), (task) => emit(TaskLoaded(task)));
    });
    on<UpdateTask>((event, emit) async {
      page = 0;

      emit(TaskLoading());
      log(event.task.toString());
      final result = await _updateTaskUseCase(UpdateTaskUseCaseParams(taskEntity: event.task));
      result.fold((l) => emit(TaskError('Failed to update task.')), (task) => emit(TaskOperationSuccess(task)));
    });
    on<AddTask>((event, emit) async {
      page = 0;
      emit(TaskLoading());
      log(event.task.toString());
      final result = await _createTaskUseCase(CreateTaskUseCaseParams(taskEntity: event.task));
      result.fold((l) => emit(TaskError('Failed to create task.')), (task) => emit(TaskOperationSuccess(task)));
    });
    on<DeleteTask>((event, emit) async {
      page = 0;
      emit(TaskLoading());
      log(event.taskId.toString());
      final result = await _deleteTaskUseCase(DeleteTaskUseCaseParams(taskId: int.parse(event.taskId)));
      result.fold((l) => emit(TaskError('Failed to Delete task.')), (task) => emit(TaskOperationSuccess(task)));
    });
  }
}
