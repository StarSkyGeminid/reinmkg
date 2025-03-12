import 'package:daylight/daylight.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import 'administration_entity.dart';

class LocationEntity extends Equatable {
  final AdministrationEntity? administration;
  final String? vilage;
  final String? subdistrict;
  final String? regency;
  final String? province;
  final double? latitude;
  final double? longitude;
  final double? altitude;
  final DateTime? time;

  const LocationEntity({
    this.administration,
    this.vilage,
    this.subdistrict,
    this.regency,
    this.province,
    this.latitude,
    this.longitude,
    this.altitude,
    this.time,
  });

  @override
  List<Object?> get props => [
        administration,
        vilage,
        subdistrict,
        regency,
        province,
        latitude,
        longitude,
        altitude,
        time,
      ];

  DaylightResult? dailyLights(DateTime dateTime) {
    if (latitude == null || longitude == null) return null;

    final currentLocation = DaylightLocation(latitude!, longitude!);

    final calculator = DaylightCalculator(currentLocation);
    return calculator.calculateForDay(dateTime, Zenith.official);
  }

  bool isDay() {
    final now = time ?? DateTime.now();

    final dailyResults = dailyLights(now);

    if (dailyResults == null) return true;

    final isDay = now.isAfter(dailyResults.sunrise!.toLocal()) &&
        now.isBefore(dailyResults.sunset!.toLocal());
    return isDay;
  }

  LatLng? toLatLng() => latitude != null && longitude != null
      ? LatLng(latitude!, longitude!)
      : null;
}
