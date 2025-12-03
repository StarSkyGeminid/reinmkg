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
    ];
  }
}
