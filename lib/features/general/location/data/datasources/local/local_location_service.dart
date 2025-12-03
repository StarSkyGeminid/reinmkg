import 'package:flutter/material.dart';
import 'package:location/location.dart';

abstract class LocalLocationService {
  @protected
  LocationData? locationData;

  factory LocalLocationService() = LocalLocationServiceImpl;

  Future<LocationData?> getCurrentCoordinate();
}

class LocalLocationServiceImpl implements LocalLocationService {
  @override
  LocationData? locationData;

  @override
  Future<LocationData?> getCurrentCoordinate() async {
    if (locationData != null) return locationData;

    final Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return location.getLocation();
  }
}
