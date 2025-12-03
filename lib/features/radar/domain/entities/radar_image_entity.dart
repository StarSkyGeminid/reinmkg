import 'package:equatable/equatable.dart';

import '../enumerate/radar_type.dart';

class RadarImageEntity extends Equatable {
  final RadarType? type;
  final DateTime? time;
  final String? file;

  const RadarImageEntity({this.type, this.time, this.file});

  @override
  List<Object?> get props => [type, time, file];
}
