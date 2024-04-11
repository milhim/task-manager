import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/src/core/common/data/error_model.dart';
import 'package:task_manager/src/core/use_cases/use_cases.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/domain/repositories/task_repository.dart';

class GetTaskUseCase implements UseCase<TaskEntity, Params> {
  final TaskRepository repository;

  GetTaskUseCase({required this.repository});

  @override
  Future<Either<ErrorModel, TaskEntity>> call(Params params) async {
    return await repository.getTask(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({required this.id});

  @override
  List<Object?> get props => [id];
}
