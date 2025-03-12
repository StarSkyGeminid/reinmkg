// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:reinmkg/core/core.dart';

class WaterWaveEntity extends Equatable {
  final String? id;
  final DateTime? time;
  final WaveHeight? today;
  final WaveHeight? tommorow;
  final WaveHeight? h2;
  final WaveHeight? h3;

  const WaterWaveEntity({
    this.id,
    this.time,
    this.today,
    this.tommorow,
    this.h2,
    this.h3,
  });

  @override
  List<Object?> get props {
    return [
      id,
      time,
      today,
      tommorow,
      h2,
      h3,
    ];
  }
}
