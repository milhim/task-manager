import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/src/core/common/data/error_model.dart';
import 'package:task_manager/src/core/use_cases/use_cases.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/domain/repositories/task_repository.dart';

class CreateTaskUseCase implements UseCase<bool, CreateTaskUseCaseParams> {
  final TaskRepository repository;

  CreateTaskUseCase({required this.repository});

  @override
  Future<Either<ErrorModel, bool>> call(CreateTaskUseCaseParams params) async {
    return await repository.createTask(params.taskEntity);
  }
}

class CreateTaskUseCaseParams extends Equatable {
  final TaskEntity taskEntity;

  CreateTaskUseCaseParams({required this.taskEntity});

  @override
  List<Object?> get props => [taskEntity];
}
