import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/src/core/common/data/error_model.dart';
import 'package:task_manager/src/core/use_cases/use_cases.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/domain/repositories/task_repository.dart';

class GetTasksUseCase implements UseCase<List<TaskEntity>, GetTasksParams> {
  final TaskRepository repository;

  GetTasksUseCase({required this.repository});

  Future<Either<ErrorModel, List<TaskEntity>>> call(GetTasksParams params) async {
    return await repository.getTasks(params.page);
  }
}

class GetTasksParams extends Equatable {
  final int page;

  GetTasksParams({required this.page});

  @override
  List<Object?> get props => [page];
}
