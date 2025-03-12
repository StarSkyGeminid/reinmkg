import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetProvinceBorderUsecase extends UseCase<String, void> {
  final GeojsonRepository _repository;

  GetProvinceBorderUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call({void params}) {
    return _repository.getProvinceBorder();
  }
}
