import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/common/data/error_model.dart';
import 'package:task_manager/features/auth/domain/entities/login_form_entity.dart';
import 'package:task_manager/features/auth/domain/entities/login_response_entity.dart';
import 'package:task_manager/features/auth/domain/use_cases/login_use_case.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      if (event is DoLogin) {
        emit(LoginILoadingState());
        final userIssues = await _loginUseCase(LoginParams(entity: event.loginFormEntity));
        emit(
          userIssues.fold((ErrorModel error) {
            return LoginErrorState(errorModel: error);
          }, (LoginResponseEntity loginResponseEntity) {
            return LoginSuccessState(loginResponseEntity: loginResponseEntity);
          }),
        );
      }
    });
  }
}
