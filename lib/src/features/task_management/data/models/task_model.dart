// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:task_manager/src/features/task_management/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  final int id;
  final String name;
  final int year;
  final String color;
  final String pantoneValue;
  TaskModel({
    required this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
  }) : super(id: id, name: name, year: year, color: color, pantoneValue: pantoneValue);

  @override
  // TODO: implement props
  List<Object> get props {
    return [
      id,
      name,
      year,
      color,
      pantoneValue,
    ];
  }

  TaskModel copyWith({
    int? id,
    String? name,
    int? year,
    String? color,
    String? pantoneValue,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      year: year ?? this.year,
      color: color ?? this.color,
      pantoneValue: pantoneValue ?? this.pantoneValue,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'year': year,
      'color': color,
      'pantone_value': pantoneValue,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      name: map['name'].toString(),
      year: map['year'],
      color: map['color'].toString(),
      pantoneValue: map['pantone_value'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(dynamic source) => TaskModel.fromMap(source);

  @override
  bool get stringify => true;
}
