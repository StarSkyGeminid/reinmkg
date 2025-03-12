import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetCloudRadars extends UseCase<List<RadarEntity>, void> {
  final RadarRepository _repository;

  GetCloudRadars(this._repository);

  @override
  Future<Either<Failure, List<RadarEntity>>> call({void params}) {
    return _repository.getAllRadar();
  }
}
