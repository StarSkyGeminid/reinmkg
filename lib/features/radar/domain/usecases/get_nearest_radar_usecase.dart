import '../entities/radar_entity.dart';
import '../repositories/radar_repository.dart';

class GetNearestRadarUsecase {
  final RadarRepository _radarRepository;

  GetNearestRadarUsecase(this._radarRepository);

  Future<RadarEntity> call(double latitude, double longitude) async {
    return _radarRepository.getNearest(latitude, longitude);
  }
}
