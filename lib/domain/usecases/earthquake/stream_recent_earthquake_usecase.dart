import 'package:reinmkg/domain/domain.dart';

class StreamRecentEarthquake {
  final EarthquakeRepository _repository;

  StreamRecentEarthquake(this._repository);

  Stream<EarthquakeEntity> call() {
    return _repository.streamRecentEarthquake();
  }
}
