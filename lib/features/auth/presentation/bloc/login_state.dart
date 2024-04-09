part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitialState extends LoginState {}

final class LoginILoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final LoginResponseEntity loginResponseEntity;

  LoginSuccessState({required this.loginResponseEntity});
}

final class LoginErrorState extends LoginState {
  final ErrorModel errorModel;

  const LoginErrorState({required this.errorModel});
}
