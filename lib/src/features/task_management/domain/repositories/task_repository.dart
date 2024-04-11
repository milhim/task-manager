import 'package:dartz/dartz.dart';
import 'package:task_manager/src/core/common/data/error_model.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<Either<ErrorModel, List<TaskEntity>>> getTasks(int page);
  Future<Either<ErrorModel, TaskEntity>> getTask(int? id);
  Future<Either<ErrorModel, bool>> createTask(TaskEntity taskEntity);
  Future<Either<ErrorModel, bool>> updateTask(TaskEntity taskEntity);
  Future<Either<ErrorModel, bool>> deleteTask(int id);
}
