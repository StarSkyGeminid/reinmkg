// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CelestialEntity extends Equatable {
  final double? azimuth;
  final double? altitude;
  final double? rightAscension;
  final double? declination;
  final DateTime? riseTime;
  final DateTime? setTime;
  final DateTime? transitTime;
  final double? illumination;
  final double? phaseAngle;
  final double? ageInDays;

  const CelestialEntity({
    this.azimuth,
    this.altitude,
    this.rightAscension,
    this.declination,
    this.riseTime,
    this.setTime,
    this.transitTime,
    this.illumination = 0.0,
    this.phaseAngle,
    this.ageInDays,
  });

  @override
  List<Object?> get props {
    return [
      azimuth,
      altitude,
      rightAscension,
      declination,
      riseTime,
      setTime,
      transitTime,
      illumination,
      phaseAngle,
      ageInDays,
    ];
  }
}
