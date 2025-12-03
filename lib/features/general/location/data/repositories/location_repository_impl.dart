import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/utils/services/sharedprefs/shared_prefs_mixin.dart';
import 'dart:convert' as convert;

import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/datasources.dart';
import '../models/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocalLocationService _localLocationService;
  final RemoteLocationService _remoteLocationService;
  final SharedPrefsMixin _sharedPrefsMixin;

  LocationRepositoryImpl(
    this._localLocationService,
    this._remoteLocationService,
    this._sharedPrefsMixin,
  );

  LocationModel? _currentLocation;

  Future<LocationEntity>? _ongoingRequest;

  @override
  Future<LocationEntity> getCurrentLocation() {
    if (_currentLocation != null) {
      return Future.value(_currentLocation);
    }

    return refreshLocation();
  }

  @override
  Future<LocationEntity> getLastLocation() {
    final stored = _sharedPrefsMixin.getData(PrefsKeys.location);

    if (stored == null) {
      throw Exception('No cached location available');
    }

    final lastLocation = LocationModel.fromJson(
      convert.jsonDecode(stored) as Map<String, dynamic>,
    );

    _currentLocation = lastLocation;

    return Future.value(lastLocation);
  }

  @override
  Future<LocationEntity> refreshLocation() async {
    if (_ongoingRequest != null) return _ongoingRequest!;

    _ongoingRequest = _refreshLocationInternal();

    try {
      final result = await _ongoingRequest!;
      return result;
    } finally {
      _ongoingRequest = null;
    }
  }

  Future<LocationEntity> _refreshLocationInternal() async {
    final locationData = await _localLocationService.getCurrentCoordinate();

    if (locationData == null) {
      throw Exception('Unable to retrieve current location');
    }

    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) {
      throw Exception('Invalid location data');
    }

    try {
      final stored = _sharedPrefsMixin.getData(PrefsKeys.location);

      if (stored != null) {
        final cached = LocationModel.fromJson(
          convert.jsonDecode(stored) as Map<String, dynamic>,
        );

        final cachedLat = cached.latitude;
        final cachedLon = cached.longitude;

        if (cachedLat != null && cachedLon != null) {
          final distance = Distance().distance(
            LatLng(latitude, longitude),
            LatLng(cachedLat, cachedLon),
          );

          if (distance <= 300) {
            _currentLocation = cached;
            return cached;
          }
        }
      }
    } catch (_) {}

    try {
      final nearestLocation = await _remoteLocationService.getNearestLocation(
        latitude,
        longitude,
      );

      final updatedLocation = nearestLocation.copyWith(
        latitude: latitude,
        longitude: longitude,
      );

      _sharedPrefsMixin.addData(
        PrefsKeys.location,
        convert.jsonEncode(updatedLocation.toJson()),
      );

      _currentLocation = updatedLocation;

      return updatedLocation;
    } catch (e) {
      final stored = _sharedPrefsMixin.getData(PrefsKeys.location);

      return LocationModel.fromJson(
        convert.jsonDecode(stored) as Map<String, dynamic>,
      );
    }
  }
}
