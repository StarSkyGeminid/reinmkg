import 'package:reinmkg/domain/domain.dart';

class StreamLastEarthquakeFelt {
  final EarthquakeRepository _repository;

  StreamLastEarthquakeFelt(this._repository);

  Stream<EarthquakeEntity> call() {
    return _repository.streamLastEarthquakeFelt();
  }
}
