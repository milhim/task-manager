part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class LoadTask extends TaskEvent {
  final String taskId;

  LoadTask({required this.taskId});
}

class AddTask extends TaskEvent {
  final TaskEntity task;

  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskEntity task;

  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskId;

  DeleteTask(this.taskId);
}
