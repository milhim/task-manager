import 'package:dartz/dartz.dart';
import 'package:task_manager/core/common/data/error_model.dart';

abstract class UseCase<Type, Params> {
  Future<Either<ErrorModel, Type>> call(Params params);
}
