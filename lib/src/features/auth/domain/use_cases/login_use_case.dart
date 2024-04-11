import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/src/core/common/data/error_model.dart';
import 'package:task_manager/src/features/auth/domain/entities/login_form_entity.dart';
import 'package:task_manager/src/features/auth/domain/entities/login_response_entity.dart';
import 'package:task_manager/src/features/auth/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<ErrorModel, LoginResponseEntity>> call(
    LoginParams? params,
  ) {
    return repository.login(params);
  }
}

class LoginParams extends Equatable {
  late String? email;
  late String? password;
  LoginParams({required LoginFormEntity entity}) {
    email = entity.email;
    password = entity.password;
  }

  @override
  List<Object> get props => [];
}
