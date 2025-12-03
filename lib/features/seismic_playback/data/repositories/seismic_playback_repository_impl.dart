import 'dart:async';

import '../../domain/entities/earthquake_pga_entity.dart';
import '../../domain/repositories/seismic_playback_repository.dart';
import '../datasources/remote/remote_seismic_playback_service.dart';

class SeismicPlaybackRepositoryImpl implements SeismicPlaybackRepository {
  final RemoteSeismicPlaybackService _remoteSeismicPlaybackService;

  SeismicPlaybackRepositoryImpl(this._remoteSeismicPlaybackService);

  @override
  Future<List<EarthquakePgaEntity>> getEarthquakePgaData(String eventId) async {
    try {
      final remote = await _remoteSeismicPlaybackService.getEarthquakePgaData(
        eventId,
      );
      return remote;
    } catch (_) {
      throw Exception('Failed to fetch Earthquake PGA data');
    }
  }
}
