import 'package:equatable/equatable.dart';

class LoginFormEntity extends Equatable {
  String? email;
  String? password;

  LoginFormEntity({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
