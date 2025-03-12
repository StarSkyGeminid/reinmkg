import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/domain/domain.dart';

class GetSateliteImages extends UseCase<List<String>, void> {
  final WeatherRepository _repository;

  GetSateliteImages(this._repository);

  @override
  Future<Either<Failure, List<String>>> call({void params}) {
    return _repository.getSateliteImages();
  }
}
