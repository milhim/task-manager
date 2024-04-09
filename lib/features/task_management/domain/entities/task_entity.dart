import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String name;
  final int year;
  final String color;
  final String pantoneValue;

  TaskEntity({
    this.id,
    required this.name,
    required this.year,
    required this.color,
    required this.pantoneValue,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, year, color, pantoneValue];
}
