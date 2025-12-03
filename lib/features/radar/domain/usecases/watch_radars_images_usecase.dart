import '../entities/radar_image_entity.dart';
import '../repositories/radar_repository.dart';

class WatchRadarImagesUsecase {
  RadarRepository repository;

  WatchRadarImagesUsecase(this.repository);

  Stream<List<RadarImageEntity>> call() {
    return repository.watchRadarImages();
  }
}
