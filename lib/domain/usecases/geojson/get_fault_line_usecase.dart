import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetFaultLineUsecase extends UseCase<String, void> {
  final GeojsonRepository _repository;

  GetFaultLineUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call({void params}) {
    return _repository.getFaultLine();
  }
}
