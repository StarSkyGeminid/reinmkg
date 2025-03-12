import 'package:intl/intl.dart';

import '../../../core/enumerate/wave_height.dart';
import '../../../domain/entities/weather/water_wave_entity.dart';

class WaterWaveModel extends WaterWaveEntity {
  const WaterWaveModel({
    super.id,
    super.time,
    super.today,
    super.tommorow,
    super.h2,
    super.h3,
  });

  factory WaterWaveModel.fromJson(Map<String, dynamic> json) {
    final key = json.keys.first;

    json = json[key];

    return WaterWaveModel(
      id: key,
      time: json['issued'] != null
          ? DateFormat('yyyy-MM-dd HH:mm').parse(
              (json['issued'] as String).replaceAll(' UTC', ''),
              true,
            )
          : null,
      today:
          json['today'] != null ? WaveHeight.fromString(json['today']) : null,
      tommorow: json['tommorow'] != null
          ? WaveHeight.fromString(json['tommorow'])
          : null,
      h2: json['h2'] != null ? WaveHeight.fromString(json['h2']) : null,
      h3: json['h3'] != null ? WaveHeight.fromString(json['h3']) : null,
    );
  }

  factory WaterWaveModel.fromEntity(WaterWaveEntity entity) {
    return WaterWaveModel(
      id: entity.id,
      time: entity.time,
      today: entity.today,
      tommorow: entity.tommorow,
      h2: entity.h2,
      h3: entity.h3,
    );
  }

  WaterWaveModel copyWith({
    String? id,
    DateTime? time,
    WaveHeight? today,
    WaveHeight? tommorow,
    WaveHeight? h2,
    WaveHeight? h3,
  }) {
    return WaterWaveModel(
      id: id ?? this.id,
      time: time ?? this.time,
      today: today ?? this.today,
      tommorow: tommorow ?? this.tommorow,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time?.toIso8601String(),
      'today': today,
      'tommorow': tommorow,
      'h2': h2,
      'h3': h3,
    };
  }
}
