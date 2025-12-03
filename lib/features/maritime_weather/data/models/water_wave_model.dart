import 'package:intl/intl.dart';

import '../../domain/entities/water_wave_entity.dart';
import '../../../../core/shared/features/geojson_data/domain/enumerate/wave_height.dart';

extension on String {
  WaveHeight toWaveHeight() {
    switch (toLowerCase()) {
      case 'tenang':
        return WaveHeight.calm;
      case 'rendah':
        return WaveHeight.low;
      case 'sedang':
        return WaveHeight.medium;
      case 'tinggi':
        return WaveHeight.high;
      case 'sangat tinggi':
        return WaveHeight.veryHigh;
      case 'ekstrim':
        return WaveHeight.extreme;
      case 'sangat ekstrim':
        return WaveHeight.veryExtreme;
      default:
        throw Exception('Unknown wave height string: $this');
    }
  }
}

class WaterWaveModel extends WaterWaveEntity {
  const WaterWaveModel({
    super.id,
    super.time,
    super.today,
    super.h1,
    super.h2,
    super.h3,
  });

  factory WaterWaveModel.fromJson(Map<String, dynamic> json) {
    final key = json.keys.first;

    json = json[key];

    return WaterWaveModel(
      id: key,
      time: json['issued'] != null
          ? DateFormat(
              'yyyy-MM-dd HH:mm',
            ).parse((json['issued'] as String).replaceAll(' UTC', ''), true)
          : null,
      today: (json['today'] as String?)?.toWaveHeight(),
      h1: (json['tommorow'] as String?)?.toWaveHeight(),
      h2: (json['h2'] as String?)?.toWaveHeight(),
      h3: (json['h3'] as String?)?.toWaveHeight(),
    );
  }

  factory WaterWaveModel.fromEntity(WaterWaveEntity entity) {
    return WaterWaveModel(
      id: entity.id,
      time: entity.time,
      today: entity.today,
      h1: entity.h1,
      h2: entity.h2,
      h3: entity.h3,
    );
  }

  WaterWaveModel copyWith({
    String? id,
    DateTime? time,
    WaveHeight? today,
    WaveHeight? h1,
    WaveHeight? h2,
    WaveHeight? h3,
  }) {
    return WaterWaveModel(
      id: id ?? this.id,
      time: time ?? this.time,
      today: today ?? this.today,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time?.toIso8601String(),
      'today': today,
      'h1': h1,
      'h2': h2,
      'h3': h3,
    };
  }
}
