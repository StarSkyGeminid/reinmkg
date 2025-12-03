import '../entities/earthquake_pga_entity.dart';
import '../repositories/seismic_playback_repository.dart';

class GetEarthquakePgaDataUsecase {
  SeismicPlaybackRepository repository;

  GetEarthquakePgaDataUsecase(this.repository);

  Future<List<EarthquakePgaEntity>> call(String eventId) async {
    return repository.getEarthquakePgaData(eventId);
  }
}
