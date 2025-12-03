import 'package:froom/froom.dart';

import '../../domain/entities/tsunami_entity.dart';
import '../../domain/entities/warning_zone_entity.dart';
import 'earthquake_model.dart';
import 'warning_zone_model.dart';

@Entity(
  tableName: 'tsunami',
  primaryKeys: ['id'],
  foreignKeys: [
    ForeignKey(
      entity: EarthquakeModel,
      parentColumns: ['id'],
      childColumns: ['eventId'],
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class TsunamiModel extends TsunamiEntity {
  const TsunamiModel({
    super.id,
    super.eventId,
    super.shakemap,
    super.wzmapUrl,
    super.ttmapUrl,
    super.sshmmapUrl,
    super.warningZone,
  });

  factory TsunamiModel.fromJson(Map<String, dynamic> json) {
    var id = json['eventId'] != null ? 'tsnm_${json['eventId']}' : null;
    final domain = 'https://static.bmkg.go.id/';

    return TsunamiModel(
      id: id,
      eventId: json['eventId'],
      shakemap: json['shakemap'] != null ? '$domain${json['shakemap']}' : null,
      wzmapUrl: json['wzmap'] != null ? '$domain${json['wzmap']}' : null,
      ttmapUrl: json['ttmap'] != null ? '$domain${json['ttmap']}' : null,
      sshmmapUrl: json['sshmap'] != null ? '$domain${json['sshmap']}' : null,
      warningZone: json.containsKey('wzarea')
          ? (json['wzarea'])
                .map<WarningZoneModel>(
                  (e) => WarningZoneModel.fromJson(e, tsunamiId: id),
                )
                .toList()
          : null,
    );
  }

  factory TsunamiModel.fromEntity(TsunamiEntity entity) {
    return TsunamiModel(
      shakemap: entity.shakemap,
      wzmapUrl: entity.wzmapUrl,
      ttmapUrl: entity.ttmapUrl,
      sshmmapUrl: entity.sshmmapUrl,
      warningZone: entity.warningZone,
    );
  }

  TsunamiModel copyWith({
    String? subject,
    String? shakemap,
    String? wzmapUrl,
    String? ttmapUrl,
    String? sshmmapUrl,
    List<WarningZoneEntity>? warningZone,
  }) {
    return TsunamiModel(
      shakemap: shakemap ?? this.shakemap,
      wzmapUrl: wzmapUrl ?? this.wzmapUrl,
      ttmapUrl: ttmapUrl ?? this.ttmapUrl,
      sshmmapUrl: sshmmapUrl ?? sshmmapUrl,
      warningZone: warningZone ?? this.warningZone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shakemap': shakemap,
      'wzmapUrl': wzmapUrl,
      'ttmapUrl': ttmapUrl,
      'sshmmapUrl': sshmmapUrl,
      'warningZone': warningZone?.map((e) => e.toJson()),
    };
  }
}
