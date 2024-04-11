import 'dart:developer';
import 'package:task_manager/src/core/common/network/api_respone_model.dart';
import 'package:task_manager/src/core/common/network/data_loader.dart';
import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';

abstract class TaskDataSource {
  Future<ApiResponse> getTasks(int page);
  Future<ApiResponse> getTask(int id);
  Future<ApiResponse> updateTask(TaskEntity taskEntity);
  Future<ApiResponse> createTask(TaskEntity taskEntity);
  Future<ApiResponse> deleteTask(int id);
}

class TaskDataSourceImpl implements TaskDataSource {
  @override
  Future<ApiResponse> getTasks(int page) async {
    final response = await DataLoader.getRequest(
      url: '${DataLoader.getTasksURL}?page=$page',
    );
    return response;
  }

  @override
  Future<ApiResponse> getTask(int id) async {
    final response = await DataLoader.getRequest(
      url: '${DataLoader.getTaskURL}/$id',
    );
    return response;
  }

  @override
  Future<ApiResponse> updateTask(TaskEntity taskEntity) async {
    log('update data source ${taskEntity.toString()}');
    final payload = {
      "name": taskEntity.name,
      "color": taskEntity.color,
      "pantone_value": taskEntity.pantoneValue,
      "year": taskEntity.year
    };
    final response = await DataLoader.putRequest(url: '${DataLoader.updateTaskURL}/${taskEntity.id}', body: payload);
    return response;
  }

  @override
  Future<ApiResponse> createTask(TaskEntity taskEntity) async {
    log('create data source ${taskEntity.toString()}');
    final payload = {
      "name": taskEntity.name,
      "color": taskEntity.color,
      "pantone_value": taskEntity.pantoneValue,
      "year": taskEntity.year
    };
    final response = await DataLoader.postRequest(url: DataLoader.createTaskURL, body: payload);
    return response;
  }

  @override
  Future<ApiResponse> deleteTask(int id) async {
    final response = await DataLoader.deleteRequest(url: '${DataLoader.deleteTaskURL}/$id');
    return response;
  }
}
