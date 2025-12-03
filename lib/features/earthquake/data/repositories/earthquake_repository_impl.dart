import 'dart:async';

import 'package:reinmkg/features/earthquake/data/datasources/local/local_earthquake_service.dart';
import 'package:reinmkg/features/earthquake/data/datasources/remote/remote_earthquake_service.dart';
import 'package:reinmkg/features/earthquake/domain/entities/earthquake_entity.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/features/earthquake/domain/enumerates/earthquakes_type.dart';

import '../../domain/repositories/earthquake_repository.dart';

class EarthquakeRepositoryImpl implements EarthquakeRepository {
  final RemoteEarthquakeService _remoteEarthquakeService;
  final LocalEarthquakeService _localEarthquakeService;

  static const int _timeThresholdSeconds = 60;
  static const double _distanceKmThreshold = 30.0;
  static const double _magnitudeThreshold = 0.5;

  EarthquakeRepositoryImpl(
    this._remoteEarthquakeService,
    this._localEarthquakeService,
  ) {
    _initStreams();
  }

  final StreamController<EarthquakeEntity> _selectedController =
      StreamController<EarthquakeEntity>.broadcast();

  final StreamController<EarthquakeEntity> _lastFeltController =
      StreamController<EarthquakeEntity>.broadcast();

  final StreamController<EarthquakeEntity> _recentController =
      StreamController<EarthquakeEntity>.broadcast();

  Future<void> _initStreams() async {
    try {
      final last = await getLastEarthquakeFelt();
      _lastFeltController.add(last);
    } catch (_) {}

    try {
      final recent = await getRecentEarthquake();
      _recentController.add(recent);
    } catch (_) {}
  }

  @override
  Future<List<EarthquakeEntity>> getEarthquakeHistories() async {
    final oneWeek = await getOneWeekEarthquakes();
    final felt = await getListEarthquakesFelt();

    final List<EarthquakeEntity> histories = [];

    if (felt.isNotEmpty) histories.addAll(felt);
    if (oneWeek.isNotEmpty) histories.addAll(oneWeek.reversed);

    final List<EarthquakeEntity> unique = [];

    for (final e in histories) {
      EarthquakeEntity? existing;
      int existingIndex = -1;
      for (var i = 0; i < unique.length; i++) {
        final u = unique[i];
        if (_isSameEvent(u, e)) {
          existing = u;
          existingIndex = i;
          break;
        }
      }

      if (existing == null) {
        unique.add(e);
        continue;
      }

      final bool newIsFelt = felt.any((f) => _isSameEvent(f, e));
      final existingNonNull = existing;
      final bool existingIsFelt = felt.any(
        (f) => _isSameEvent(f, existingNonNull),
      );

      if (newIsFelt && !existingIsFelt) {
        unique[existingIndex] = e;
      }
    }

    return unique.reversed.toList();
  }

  bool _isSameEvent(EarthquakeEntity a, EarthquakeEntity b) {
    if (a.id != null && b.id != null && a.id!.isNotEmpty && a.id == b.id) {
      return true;
    }

    if (a.time != null && b.time != null) {
      final timeDiff = a.time!.difference(b.time!).inSeconds.abs();
      if (timeDiff > _timeThresholdSeconds) {
        return false;
      }
    }

    final LatLng? pa = a.point?.toLatLng();
    final LatLng? pb = b.point?.toLatLng();
    if (pa != null && pb != null) {
      final meters = const Distance().distance(pa, pb);
      final km = meters / 1000.0;
      if (km > _distanceKmThreshold) return false;
    }

    if (a.magnitude != null && b.magnitude != null) {
      if ((a.magnitude! - b.magnitude!).abs() > _magnitudeThreshold) {
        return false;
      }
    }

    return true;
  }

  @override
  Future<List<EarthquakeEntity>> getEarthquakesByType(
    EarthquakesType type,
  ) async {
    try {
      final list = await _remoteEarthquakeService.getEarthquakesByType(type);
      return list;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<EarthquakeEntity> getLastEarthquakeFelt() async {
    try {
      final remote = await _remoteEarthquakeService.getLastEarthquakeFelt();
      try {
        await _localEarthquakeService.replaceLastEarthquakeFelt([remote]);
      } catch (_) {}

      _lastFeltController.add(remote);
      return remote;
    } catch (_) {
      final local = await _localEarthquakeService.getLastEarthquakeFelt();
      _lastFeltController.add(local);
      return local;
    }
  }

  @override
  Future<List<EarthquakeEntity>> getListEarthquakesFelt() async {
    try {
      final remote = await _remoteEarthquakeService.getListEarthquakesFelt();
      try {
        await _localEarthquakeService.replaceLastEarthquakeFelt(remote);
      } catch (_) {}
      return remote;
    } catch (_) {
      return await _localEarthquakeService.getListEarthquakesFelt();
    }
  }

  @override
  Future<List<EarthquakeEntity>> getOneWeekEarthquakes() async {
    try {
      final remote = await _remoteEarthquakeService.getOneWeekEarthquake();
      try {
        await _localEarthquakeService.replaceOneWeekEarthquake(remote);
      } catch (_) {}
      return remote;
    } catch (_) {
      return await _localEarthquakeService.getOneWeekEarthquakes();
    }
  }

  @override
  Future<EarthquakeEntity> getRecentEarthquake() async {
    try {
      final remote = await _remoteEarthquakeService.getRecentEarthquake();
      _recentController.add(remote);
      return remote;
    } catch (_) {
      final local = await _localEarthquakeService.getRecentEarthquake();
      _recentController.add(local);
      return local;
    }
  }

  @override
  void setSelectedEarthquake(EarthquakeEntity earthquakeEntity) {
    _selectedController.add(earthquakeEntity);
  }

  @override
  Stream<EarthquakeEntity> watchLastEarthquakeFelt() =>
      _lastFeltController.stream.asBroadcastStream();

  @override
  Stream<EarthquakeEntity> watchRecentEarthquake() =>
      _recentController.stream.asBroadcastStream();

  @override
  Stream<EarthquakeEntity> watchSelectedEarthquake() =>
      _selectedController.stream.asBroadcastStream();
}
