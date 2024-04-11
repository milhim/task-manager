part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {
  final List<TaskEntity>? oldTasks;
  final bool? isFirstFetch;
  const TaskLoading({this.oldTasks, this.isFirstFetch = false});
}

class TasksLoaded extends TaskState {
  final List<TaskEntity> tasks;

  TasksLoaded(this.tasks);
}

class TaskLoaded extends TaskState {
  final TaskEntity task;

  TaskLoaded(this.task);
}

class TaskOperationSuccess extends TaskState {
  final bool result;

  TaskOperationSuccess(this.result);
}

class TaskError extends TaskState {
  final String errorMessage;

  TaskError(this.errorMessage);
}
