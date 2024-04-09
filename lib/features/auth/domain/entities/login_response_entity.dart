import 'package:equatable/equatable.dart';

class LoginResponseEntity extends Equatable {
  String? token;
  String? error;

  LoginResponseEntity({required this.token, required this.error});

  @override
  List<Object?> get props => [token, error];
}
