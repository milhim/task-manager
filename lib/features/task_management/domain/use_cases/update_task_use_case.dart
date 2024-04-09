import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/core/common/data/error_model.dart';
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/core/use_cases/use_cases.dart';
import 'package:task_manager/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/features/task_management/domain/repositories/task_repository.dart';

class UpdateTaskUseCase implements UseCase<bool, UpdateTaskUseCaseParams> {
  final TaskRepository repository;

  UpdateTaskUseCase({required this.repository});

  @override
  Future<Either<ErrorModel, bool>> call(UpdateTaskUseCaseParams params) async {
    return await repository.updateTask(params.taskEntity);
  }
}

class UpdateTaskUseCaseParams extends Equatable {
  final TaskEntity taskEntity;

  UpdateTaskUseCaseParams({required this.taskEntity});

  @override
  List<Object?> get props => [taskEntity];
}
