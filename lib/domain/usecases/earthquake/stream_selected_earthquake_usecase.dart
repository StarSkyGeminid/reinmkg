import 'package:reinmkg/domain/domain.dart';

class GetSelectedEarthquake {
  final EarthquakeRepository _repository;

  GetSelectedEarthquake(this._repository);

  Stream<EarthquakeEntity> call({void params}) {
    return _repository.streamSelectedEarthquake();
  }
}
