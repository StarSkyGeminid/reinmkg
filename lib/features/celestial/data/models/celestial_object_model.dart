import '../../domain/entities/celestial_object_entity.dart';

class CelestialObjectModel extends CelestialObjectEntity {
  const CelestialObjectModel({
    super.altitude,
    super.azimuth,
    super.distance,
    super.parallacticAngle,
    super.fraction,
    super.phase,
    super.angle,
    super.riseTime,
    super.setTime,
    super.solarNoon,
    super.dawn,
    super.dusk,
    super.goldenHour,
    super.waxing,
    super.alwaysUp,
    super.alwaysDown,
  });

  factory CelestialObjectModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String key) {
      final v = json[key];
      if (v == null) return null;
      if (v is DateTime) return v;
      return DateTime.parse(v as String);
    }

    var riseTime = json['rise'] != null
        ? json['rise'] is DateTime
              ? json['rise']
              : DateTime.parse(json['rise'] as String)
        : json['sunrise'] != null
        ? json['sunrise'] is DateTime
              ? json['sunrise']
              : DateTime.parse(json['sunrise'] as String)
        : null;
    var setTime = json['set'] != null
        ? json['set'] is DateTime
              ? json['set']
              : DateTime.parse(json['set'] as String)
        : json['sunset'] != null
        ? json['sunset'] is DateTime
              ? json['sunset']
              : DateTime.parse(json['sunset'] as String)
        : null;

    return CelestialObjectModel(
      altitude: (json['altitude'] as num?)?.toDouble(),
      azimuth: (json['azimuth'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      parallacticAngle: (json['parallacticAngle'] as num?)?.toDouble(),
      fraction: (json['fraction'] as num?)?.toDouble(),
      phase: (json['phase'] as num?)?.toDouble(),
      angle: (json['angle'] as num?)?.toDouble(),
      riseTime: riseTime,
      setTime: setTime,
      solarNoon: parseDate('solarNoon'),
      dawn: parseDate('dawn'),
      dusk: parseDate('dusk'),
      goldenHour: parseDate('goldenHour'),
      waxing: json['waxing'] as bool?,
      alwaysUp: json['alwaysUp'] as bool?,
      alwaysDown: json['alwaysDown'] as bool?,
    );
  }
}
