import '../enumerate/radar_type.dart';
import '../repositories/radar_repository.dart';

class SetRadarTypeUsecase {
  final RadarRepository _radarRepository;

  SetRadarTypeUsecase(this._radarRepository);

  Future<void> call(RadarType type) async {
    await _radarRepository.setType(type);
  }
}
