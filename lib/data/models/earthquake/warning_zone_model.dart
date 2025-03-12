import 'package:intl/intl.dart';

import '../../../core/enumerate/warning_zone_level.dart';
import '../../../domain/entities/earthquake/warning_zone_entity.dart';

class WarningZoneModel extends WarningZoneEntity {
  const WarningZoneModel({
    super.district,
    super.dateTime,
    super.level,
    super.province,
  });

  factory WarningZoneModel.fromJson(Map<String, dynamic> json) {
    DateTime dateTime;

    if (json.containsKey('time') && json['time'].contains('WIB')) {
      dateTime = DateFormat('yy-MM-dd HH:mm:ss').parse(
          '${(json['date'] as String).replaceAll(' WIB', '')} ${json['time'].split(' ')[0]}+0700');
    } else {
      dateTime = DateTime.parse(json['dateTime']);
    }

    return WarningZoneModel(
      district: json['district'],
      province: json['province'],
      level: WarningZoneLevel.fromString(json['level']),
      dateTime: dateTime,
    );
  }

  factory WarningZoneModel.fromEntity(WarningZoneEntity entity) {
    return WarningZoneModel(
      district: entity.district,
      province: entity.province,
      level: entity.level,
      dateTime: entity.dateTime,
    );
  }

  WarningZoneModel copyWith({
    String? province,
    String? district,
    WarningZoneLevel? level,
    DateTime? dateTime,
  }) {
    return WarningZoneModel(
      district: district ?? this.district,
      province: province ?? this.province,
      level: level ?? this.level,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'distric': district,
      'province': province,
      'level': level?.name,
      'dateTime': dateTime?.toIso8601String(),
    };
  }
}
