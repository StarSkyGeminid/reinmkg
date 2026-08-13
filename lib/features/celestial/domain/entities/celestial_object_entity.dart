// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CelestialObjectEntity extends Equatable {
  final double? altitude;
  final double? azimuth;
  final double? distance;
  final double? parallacticAngle;
  final double? fraction;
  final double? phase;
  final double? angle;
  final DateTime? riseTime;
  final DateTime? setTime;
  final DateTime? solarNoon;
  final DateTime? dawn;
  final DateTime? dusk;
  final DateTime? goldenHour;
  final bool? waxing;
  final bool? alwaysUp;
  final bool? alwaysDown;

  const CelestialObjectEntity({
    this.altitude,
    this.azimuth,
    this.distance,
    this.parallacticAngle,
    this.fraction,
    this.phase,
    this.angle,
    this.riseTime,
    this.setTime,
    this.solarNoon,
    this.dawn,
    this.dusk,
    this.goldenHour,
    this.waxing,
    this.alwaysUp,
    this.alwaysDown,
  });

  @override
  List<Object?> get props {
    return [
      altitude,
      azimuth,
      distance,
      parallacticAngle,
      fraction,
      phase,
      angle,
      riseTime,
      setTime,
      solarNoon,
      dawn,
      dusk,
      goldenHour,
      waxing,
      alwaysUp,
      alwaysDown,
    ];
  }
}
