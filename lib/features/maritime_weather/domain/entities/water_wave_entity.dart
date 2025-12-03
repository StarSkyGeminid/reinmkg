import 'package:equatable/equatable.dart';
import 'package:reinmkg/core/shared/features/geojson_data/domain/enumerate/wave_height.dart';

class WaterWaveEntity extends Equatable {
  final String? id;
  final DateTime? time;
  final WaveHeight? today;
  final WaveHeight? h1;
  final WaveHeight? h2;
  final WaveHeight? h3;

  const WaterWaveEntity({
    this.id,
    this.time,
    this.today,
    this.h1,
    this.h2,
    this.h3,
  });

  @override
  List<Object?> get props {
    return [id, time, today, h1, h2, h3];
  }
}
