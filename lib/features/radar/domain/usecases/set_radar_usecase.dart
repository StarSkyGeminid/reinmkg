import '../entities/radar_entity.dart';
import '../repositories/radar_repository.dart';

class SetRadarUsecase {
  final RadarRepository _radarRepository;

  SetRadarUsecase(this._radarRepository);

  Future<void> call(RadarEntity radar) async {
    await _radarRepository.setRadar(radar);
  }
}
