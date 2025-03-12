import '../../../domain/entities/celestial/celestial_entity.dart';

class CelestialModel extends CelestialEntity {
  const CelestialModel({
    super.azimuth,
    super.altitude,
    super.rightAscension,
    super.declination,
    super.riseTime,
    super.setTime,
    super.transitTime,
    super.illumination = 0.0,
    super.phaseAngle,
    super.ageInDays,
  });

  factory CelestialModel.fromEntity(CelestialEntity entity) {
    return CelestialModel(
      azimuth: entity.azimuth,
      altitude: entity.altitude,
      rightAscension: entity.rightAscension,
      declination: entity.declination,
      riseTime: entity.riseTime,
      setTime: entity.setTime,
      transitTime: entity.transitTime,
      illumination: entity.illumination,
      phaseAngle: entity.phaseAngle,
      ageInDays: entity.ageInDays,
    );
  }

  @override
  String toString() {
    return '''
        Azimuth: ${azimuth?.toStringAsFixed(2)}°
        Altitude: ${altitude?.toStringAsFixed(2)}°
        Right Ascension: ${rightAscension?.toStringAsFixed(2)}°
        Declination: ${declination?.toStringAsFixed(2)}°
        Rise: ${riseTime?.toLocal()}
        Set: ${setTime?.toLocal()}
        Transit: ${transitTime?.toLocal()}
        Illumination: ${(illumination! * 100).toStringAsFixed(1)}%
      ''';
  }

  Map<String, dynamic> toJson() => {
        'azimuth': azimuth,
        'altitude': altitude,
        'rightAscension': rightAscension,
        'declination': declination,
        'riseTime': riseTime?.toIso8601String(),
        'setTime': setTime?.toIso8601String(),
        'transitTime': transitTime?.toIso8601String(),
        'illumination': illumination,
      };
}
