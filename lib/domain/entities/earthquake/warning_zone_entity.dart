import 'package:equatable/equatable.dart';

import '../../../core/enumerate/warning_zone_level.dart';

class WarningZoneEntity extends Equatable {
  final String? province;
  final String? district;
  final WarningZoneLevel? level;
  final DateTime? dateTime;

  const WarningZoneEntity({
    this.province,
    this.district,
    this.level,
    this.dateTime,
  });

  @override
  List<Object?> get props => [
        province,
        district,
        level,
        dateTime,
      ];

  toJson() {}

}
