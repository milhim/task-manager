import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int year;
  @HiveField(3)
  final String color;
  @HiveField(4)
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
