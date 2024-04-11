import 'package:task_manager/src/core/common/network/api_respone_model.dart';
import 'package:task_manager/src/core/common/network/data_loader.dart';

abstract class LoginDataSource {
  Future<ApiResponse> login(Map<String, dynamic> data);
}

class LoginDataSourceImpl implements LoginDataSource {
  @override
  Future<ApiResponse> login(Map<String, dynamic> data) async {
    final response = await DataLoader.postRequest(
      body: data,
      url: DataLoader.loginInURL,
    );
    return response;
  }
}
