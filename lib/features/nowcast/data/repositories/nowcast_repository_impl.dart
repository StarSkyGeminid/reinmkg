import '../../domain/entities/weather_nowcast_entity.dart';
import '../../domain/repositories/nowcast_repository.dart';
import '../datasources/remote/remote_nowcast_service.dart';

class NowcastRepositoryImpl implements NowcastRepository {
  final RemoteNowcastService _remoteNowcastService;

  NowcastRepositoryImpl(this._remoteNowcastService);

  @override
  Future<List<WeatherNowcastEntity>> getNowcasts() {
    return _remoteNowcastService.getNowcasts();
  }
}
