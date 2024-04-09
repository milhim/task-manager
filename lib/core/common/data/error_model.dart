// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  const ErrorModel({
    this.error,
    this.message,
  });

  final String? error;
  final String? message;

  @override
  // TODO: implement props
  List<Object?> get props => [error, message];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'message': message,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      error: map['error'] != null ? map['error'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(dynamic source) => ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
