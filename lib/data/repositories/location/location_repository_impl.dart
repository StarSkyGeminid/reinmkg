import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/utils/services/services.dart';
import 'package:location/location.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';

class LocationRepositoryImpl with MainPrefsMixin implements LocationRepository {
  final RemoteLocationService _remoteLocationService;
  final LocalLocationService _localLocationService;
  final NetworkInfo _networkInfo;

  LocationRepositoryImpl(
    this._remoteLocationService,
    this._localLocationService,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, LocationEntity>> getNearestLocation(
      double latitude, double longitude) async {
    return _remoteLocationService.getNearestLocation(latitude, longitude);
  }

  @override
  Future<LocationData?> getCurrentCoordinate() {
    return _localLocationService.getCurrentCoordinate();
  }

  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    final currentLocation = await _getCurrentCoordinate();

    if (_networkInfo.isConnected && currentLocation != null) {
      return _getNearestLocation(currentLocation);
    }

    var lastLocation = _getSavedLocation();

    return lastLocation != null ? Right(lastLocation) : Left(NoDataFailure());
  }

  Future<Either<Failure, LocationModel>> _getNearestLocation(
      LocationData currentLocation) async {
    var savedLocation = _getSavedLocation();

    if (savedLocation?.latitude != null && savedLocation?.longitude != null) {
      var last = LatLng(savedLocation!.latitude!, savedLocation.longitude!);

      var current =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);

      if (_isNewLocationNotFar(last, current)) {
        return Right(savedLocation);
      }
    }

    if (_networkInfo.isNotConnected) {
      return savedLocation != null
          ? Right(savedLocation)
          : Left(NoDataFailure());
    }

    final location = await _remoteLocationService.getNearestLocation(
        currentLocation.latitude!, currentLocation.longitude!);

    final data = location.fold((l) => null, (r) => r);

    if (data != null) {
      var newLocation = data.copyWith(altitude: currentLocation.altitude);

      replaceData(MainPrefsKeys.location, jsonEncode(newLocation.toJson()));

      return Right(newLocation);
    }

    return savedLocation != null ? Right(savedLocation) : location;
  }

  bool _isNewLocationNotFar(LatLng current, LatLng last) {
    Distance distance = const Distance();

    return distance.as(LengthUnit.Kilometer, current, last) <= 0.5;
  }

  LocationModel? _getSavedLocation() {
    final lastLocationJson = getData(MainPrefsKeys.location);

    if (lastLocationJson == null) return null;

    final lastLocation = LocationModel.fromJson(jsonDecode(lastLocationJson));
    return lastLocation;
  }

  Future<LocationData?> _getCurrentCoordinate() async {
    final coordinate = await _localLocationService.getCurrentCoordinate();

    if (coordinate != null) {
      String jsonString = jsonEncode({
        'latitude': coordinate.latitude,
        'longitude': coordinate.longitude,
        'altitude': coordinate.altitude
      });

      replaceData(
        MainPrefsKeys.coordinate,
        jsonString,
      );

      return coordinate;
    }

    return _getSavedCoordinate();
  }

  LocationData? _getSavedCoordinate() {
    final data = getData(MainPrefsKeys.coordinate);

    if (data == null) return null;

    return LocationData.fromMap(jsonDecode(data));
  }
}
