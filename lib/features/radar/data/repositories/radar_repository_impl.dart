import 'dart:async';

import 'package:latlong2/latlong.dart';

import '../../domain/entities/radar_entity.dart';
import '../../domain/entities/radar_image_entity.dart';
import '../../domain/enumerate/radar_type.dart';
import '../../domain/repositories/radar_repository.dart';
import '../datasources/remote/remote_radar_service.dart';
import '../models/models.dart';

class RadarRepositoryImpl implements RadarRepository {
  final RemoteRadarService _remoteRadarService;

  RadarEntity? _selectedRadar;
  RadarType? _selectedType;

  List<RadarModel>? _radarsCache;
  List<RadarImageModel>? _radarImagesCache;

  RadarRepositoryImpl(this._remoteRadarService);

  Future<List<RadarModel>> _loadRadars() async {
    _radarsCache ??= await _remoteRadarService.getRadars();
    return _radarsCache!;
  }

  Future<List<RadarImageModel>> _loadRadarImages(String code) async {
    _radarImagesCache ??= await _remoteRadarService.getRadarImages(code);
    return _radarImagesCache!;
  }

  Future<List<RadarImageEntity>> _filterRadarImagesByType() async {
    if (_selectedRadar?.code == null) {
      throw Exception('No radar selected');
    }

    final imgs = await _loadRadarImages(_selectedRadar!.code!);

    final filtered = imgs.where((img) => img.type == _selectedType).toList();
    return filtered;
  }

  @override
  Future<List<RadarEntity>> getAll() async {
    final models = await _loadRadars();
    final List<RadarModel> result = List<RadarModel>.from(models);

    result.sort((a, b) {
      return a.city?.compareTo(b.city ?? '') ?? 0;
    });

    return result;
  }

  @override
  Future<RadarEntity> getNearest(double latitude, double longitude) async {
    final models = await _loadRadars();

    if (models.isEmpty) {
      throw Exception('No radars available');
    }

    final dist = const Distance();
    final loc = LatLng(latitude, longitude);

    RadarModel? nearest;
    double best = double.infinity;

    for (final r in models) {
      if (r.position == null) continue;
      final d = dist.as(LengthUnit.Kilometer, loc, r.position!);
      if (d < best) {
        best = d;
        nearest = r;
      }
    }

    return nearest ?? models.first;
  }

  @override
  Stream<List<RadarImageEntity>> watchRadarImages() {
    return Stream.fromFuture(_filterRadarImagesByType()).asBroadcastStream();
  }

  @override
  Future<List<RadarEntity>> searchRadars(String query) async {
    final models = await _loadRadars();
    final q = query.toLowerCase().trim();

    final results = models.where((m) {
      final name = (m.city ?? '').toLowerCase();
      return name.contains(q);
    }).toList();

    return results;
  }

  @override
  Future<void> setRadar(RadarEntity radar) async {
    _selectedRadar = radar;
    _radarImagesCache = null;
  }

  @override
  Future<void> setType(RadarType type) async {
    _selectedType = type;
    _radarImagesCache = null;
  }
}
