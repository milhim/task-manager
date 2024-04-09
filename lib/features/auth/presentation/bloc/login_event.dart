part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class DoLogin extends LoginEvent {
  final LoginFormEntity loginFormEntity;
  final BuildContext context;

  const DoLogin({required this.loginFormEntity, required this.context});

  @override
  // TODO: implement props
  List<Object> get props => [loginFormEntity, context];
}
