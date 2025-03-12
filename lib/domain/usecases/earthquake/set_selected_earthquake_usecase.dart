import 'package:reinmkg/domain/domain.dart';

class SetSelectedEarthquake {
  final EarthquakeRepository _repository;

  SetSelectedEarthquake(this._repository);

  void call({required EarthquakeEntity params}) {
    return _repository.setSelectedEarthquake(params);
  }
}
