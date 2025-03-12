import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/error/failure.dart';

abstract class BaseSelectableData<T> {
  Future<Either<Failure, List<T>>> getAllRadar();

  Stream<T> stream();

  void setSelected(T data);
}
