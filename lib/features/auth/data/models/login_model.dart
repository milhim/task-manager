// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String? token;
  final String? error;

  const LoginModel({
    this.token,
    this.error,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [token, error];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'error': error,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      token: map['token'] != null ? map['token'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(dynamic source) => LoginModel.fromMap(source);

  @override
  bool get stringify => true;
}
