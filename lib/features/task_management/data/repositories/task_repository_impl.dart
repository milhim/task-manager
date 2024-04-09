import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:task_manager/core/common/data/error_model.dart';
import 'package:task_manager/features/task_management/data/data_source/remote_data_source.dart';
import 'package:task_manager/features/task_management/data/models/task_model.dart';
import 'package:task_manager/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/features/task_management/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource taskDataSource;

  TaskRepositoryImpl({
    required this.taskDataSource,
  });

  @override
  Future<Either<ErrorModel, bool>> createTask(TaskEntity taskEntity) async {
    try {
      final response = await taskDataSource.createTask(taskEntity);
      log('create task logs');
      log(response.data.toString());
      log(response.message.toString());
      return Right(true);
    } catch (error, stackTrace) {
      print("ERROR get task $error");
      return Left(ErrorModel(error: error.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, bool>> deleteTask(int id) async {
    try {
      final response = await taskDataSource.deleteTask(id);
      log('delete task logs');
      log(response.data.toString());
      log(response.message.toString());
      return Right(true);
    } catch (error, stackTrace) {
      print("ERROR get task $error");
      return Left(ErrorModel(error: error.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, TaskEntity>> getTask(int? id) async {
    try {
      final response = await taskDataSource.getTask(id ?? 1);
      final task = TaskModel.fromJson(response.data?['data']);

      return Right(task);
    } catch (error, stackTrace) {
      print("ERROR get task $error");
      return Left(ErrorModel(error: error.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, List<TaskEntity>>> getTasks() async {
    // TODO: implement getTasks
    try {
      List<TaskEntity> tasks = [];
      final response = await taskDataSource.getTasks();
      List<dynamic> responseList = response.data!['data'] as List;
      tasks = responseList.map((task) => TaskModel.fromJson(task)).toList();

      return Right(tasks);
    } catch (error, stackTrace) {
      print("ERROR get tasks $error");
      return Left(ErrorModel(error: error.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, bool>> updateTask(TaskEntity taskEntity) async {
    try {
      final response = await taskDataSource.updateTask(taskEntity);
      log('update task logs');
      log(response.data.toString());
      log(response.message.toString());
      return Right(true);
    } catch (error, stackTrace) {
      print("ERROR get task $error");
      return Left(ErrorModel(error: error.toString()));
    }
  }
}
