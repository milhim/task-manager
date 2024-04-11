import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:task_manager/src/app/logic/app_settings.dart';
import 'package:task_manager/src/core/common/data/error_model.dart';
import 'package:task_manager/src/core/utils/managers/database/database_manager.dart';
import 'package:task_manager/src/features/auth/data/data_source/remote_data_source.dart';
import 'package:task_manager/src/features/auth/data/models/login_model.dart';
import 'package:task_manager/src/features/auth/domain/entities/login_response_entity.dart';
import 'package:task_manager/src/features/auth/domain/repositories/login_repository.dart';
import 'package:task_manager/src/features/auth/domain/use_cases/login_use_case.dart';
import 'package:task_manager/src/features/injection.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource loginDataSource;

  LoginRepositoryImpl({
    required this.loginDataSource,
  });

  @override
  Future<Either<ErrorModel, LoginResponseEntity>> login(LoginParams? params) async {
    try {
      Map<String, dynamic>? payload = {
        "email": params!.email,
        "password": params.password,
      };

      final response = await loginDataSource.login(payload ?? {});
      log('m1 ${response.toString()}');
      final LoginModel loginModel = LoginModel.fromJson(response.data);
      serviceLocator<AppSettings>().token = loginModel.token;
      serviceLocator<DatabaseManager>().saveData("EMAIL", params.email);
      serviceLocator<DatabaseManager>().saveData("TOKEN", loginModel.token);

      return Right(LoginResponseEntity(token: loginModel.token, error: loginModel.error));
    } catch (error, stackTrace) {
      print("ERROR DDD $error");
      return Left(ErrorModel(error: error.toString(), message: error.toString()));
    }
  }
}
