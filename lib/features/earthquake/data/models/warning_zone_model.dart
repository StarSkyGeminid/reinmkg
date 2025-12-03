import 'package:froom/froom.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/warning_zone_entity.dart';
import '../../domain/enumerates/warning_zone_level.dart';
import 'tsunami_model.dart';

@Entity(
  tableName: 'warning_zone',
  primaryKeys: ['id'],
  foreignKeys: [
    ForeignKey(
      entity: TsunamiModel,
      parentColumns: ['id'],
      childColumns: ['eventId'],
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class WarningZoneModel extends WarningZoneEntity {
  const WarningZoneModel({
    super.id,
    super.eventId,
    super.district,
    super.dateTime,
    super.level,
    super.province,
  });

  factory WarningZoneModel.fromJson(
    Map<String, dynamic> json, {
    String? tsunamiId,
  }) {
    DateTime dateTime;

    if (json.containsKey('time') && json['time'].contains('WIB')) {
      dateTime = DateFormat('yy-MM-dd HH:mm:ss').parse(
        '${(json['date'] as String).replaceAll(' WIB', '')} ${json['time'].split(' ')[0]}+0700',
      );
    } else {
      dateTime = DateTime.parse(json['dateTime']);
    }

    return WarningZoneModel(
      id: json['eventId'] != null
          ? 'wz_${json['eventId']}_${json['district']}'
          : null,
      eventId: tsunamiId,
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
