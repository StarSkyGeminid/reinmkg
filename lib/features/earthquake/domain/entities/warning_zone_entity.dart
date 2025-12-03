import 'package:equatable/equatable.dart';

import '../enumerates/warning_zone_level.dart';

class WarningZoneEntity extends Equatable {
  final String? id;
  final String? eventId;
  final String? province;
  final String? district;
  final WarningZoneLevel? level;
  final DateTime? dateTime;

  const WarningZoneEntity({
    this.id,
    this.eventId,
    this.province,
    this.district,
    this.level,
    this.dateTime,
  });

  @override
  List<Object?> get props => [
        id,
        eventId,
        province,
        district,
        level,
        dateTime,
      ];

  toJson() {}

}
