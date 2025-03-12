import 'package:reinmkg/domain/domain.dart';

class StreamSelectedRadar {
  final RadarRepository _repository;

  StreamSelectedRadar(this._repository);

  Stream<RadarEntity> call() {
    return _repository.stream();
  }
}
