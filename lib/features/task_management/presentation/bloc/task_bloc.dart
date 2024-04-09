import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/features/task_management/domain/use_cases/create_task_use_case.dart';
import 'package:task_manager/features/task_management/domain/use_cases/delete_task_use_case.dart';
import 'package:task_manager/features/task_management/domain/use_cases/get_task_use_case.dart';
import 'package:task_manager/features/task_management/domain/use_cases/get_tasks_use_case.dart';
import 'package:task_manager/features/task_management/domain/use_cases/update_task_use_case.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase _getTasksUseCase;
  final GetTaskUseCase _getTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskBloc(
      {required GetTasksUseCase getTasksUseCase,
      required GetTaskUseCase getTaskUseCase,
      required UpdateTaskUseCase updateTaskUseCase,
      required CreateTaskUseCase createTaskUseCase,
      required DeleteTaskUseCase deleteTaskUseCase})
      : _getTasksUseCase = getTasksUseCase,
        _getTaskUseCase = getTaskUseCase,
        _updateTaskUseCase = updateTaskUseCase,
        _createTaskUseCase = createTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        super(TaskInitial()) {
    on<TaskEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      final result = await _getTasksUseCase();
      result.fold((l) => emit(TaskError('Failed to load tasks.')), (tasks) => emit(TasksLoaded(tasks)));
    });
    on<LoadTask>((event, emit) async {
      emit(TaskLoading());
      final result = await _getTaskUseCase(Params(id: int.parse(event.taskId)));
      result.fold((l) => emit(TaskError('Failed to load task.')), (task) => emit(TaskLoaded(task)));
    });
    on<UpdateTask>((event, emit) async {
      emit(TaskLoading());
      log(event.task.toString());
      final result = await _updateTaskUseCase(UpdateTaskUseCaseParams(taskEntity: event.task));
      result.fold((l) => emit(TaskError('Failed to update task.')), (task) => emit(TaskOperationSuccess(task)));
    });
    on<AddTask>((event, emit) async {
      emit(TaskLoading());
      log(event.task.toString());
      final result = await _createTaskUseCase(CreateTaskUseCaseParams(taskEntity: event.task));
      result.fold((l) => emit(TaskError('Failed to create task.')), (task) => emit(TaskOperationSuccess(task)));
    });
    on<DeleteTask>((event, emit) async {
      emit(TaskLoading());
      log(event.taskId.toString());
      final result = await _deleteTaskUseCase(DeleteTaskUseCaseParams(taskId: int.parse(event.taskId)));
      result.fold((l) => emit(TaskError('Failed to Delete task.')), (task) => emit(TaskOperationSuccess(task)));
    });
  }
}
