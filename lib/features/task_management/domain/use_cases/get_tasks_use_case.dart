import 'package:dartz/dartz.dart';
import 'package:task_manager/core/common/data/error_model.dart';
import 'package:task_manager/core/error/failures.dart';
import 'package:task_manager/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/features/task_management/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase({required this.repository});

  Future<Either<ErrorModel, List<TaskEntity>>> call() async {
    return await repository.getTasks();
  }
}
