// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SuccessModel extends Equatable {
  final String? message;
  final int? statusCode;
  const SuccessModel({this.message, this.statusCode});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'statusCode': statusCode,
    };
  }

  factory SuccessModel.fromMap(Map<String, dynamic> map) {
    return SuccessModel(
      message: map['message'] != null ? map['message'] as String : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SuccessModel.fromJson(String source) => SuccessModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
