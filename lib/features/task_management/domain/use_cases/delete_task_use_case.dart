import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/common/data/error_model.dart';
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/core/use_cases/use_cases.dart';
import 'package:task_manager/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/features/task_management/domain/repositories/task_repository.dart';

class DeleteTaskUseCase implements UseCase<bool, DeleteTaskUseCaseParams> {
  final TaskRepository repository;

  DeleteTaskUseCase({required this.repository});

  @override
  Future<Either<ErrorModel, bool>> call(DeleteTaskUseCaseParams params) async {
    return await repository.deleteTask(params.taskId);
  }
}

class DeleteTaskUseCaseParams extends Equatable {
  final int taskId;

  DeleteTaskUseCaseParams({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
