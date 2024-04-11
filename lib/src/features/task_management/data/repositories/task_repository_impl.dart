import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:task_manager/src/core/common/data/error_model.dart';
import 'package:task_manager/src/core/constants/keys.dart';
import 'package:task_manager/src/core/constants/strings.dart';
import 'package:task_manager/src/core/utils/managers/database/database_manager.dart';
import 'package:task_manager/src/core/utils/managers/database/hive_service.dart';
import 'package:task_manager/src/features/injection.dart';
import 'package:task_manager/src/features/task_management/data/data_source/remote_data_source.dart';
import 'package:task_manager/src/features/task_management/data/models/task_model.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';
import 'package:task_manager/src/features/task_management/domain/repositories/task_repository.dart';

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
    } catch (error) {
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
    } catch (error) {
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
    } catch (error) {
      print("ERROR get task $error");
      return Left(ErrorModel(error: error.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, List<TaskEntity>>> getTasks(int page) async {
    // TODO: implement getTasks
    try {
      List<TaskEntity> tasks = [];
      final response = await taskDataSource.getTasks(page);
      if (response.code == NO_INTERNET_CONNECTION_ERROR_CODE) {
        return Left(ErrorModel(error: NO_INTERNET_CONNECTION_ERROR_MESSAGE));
      }
      List<dynamic> responseList = response.data!['data'] as List;
      serviceLocator<DatabaseManager>().saveData('TASKS_TOTAL_PAGES', response.data!['total_pages']);
      tasks = responseList.map((task) => TaskModel.fromJson(task)).toList();
      return Right(tasks);
    } catch (error) {
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
    } catch (error) {
      print("ERROR get task $error");
      return Left(ErrorModel(error: error.toString()));
    }
  }
}
