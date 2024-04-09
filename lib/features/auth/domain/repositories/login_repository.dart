import 'package:dartz/dartz.dart';
import 'package:task_manager/core/common/data/error_model.dart';

import '../entities/login_response_entity.dart';
import '../use_cases/login_use_case.dart';

abstract class LoginRepository {
  Future<Either<ErrorModel, LoginResponseEntity>> login(
    LoginParams? params,
  );
}
