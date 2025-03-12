import '../../../domain/entities/earthquake/tsunami_entity.dart';
import '../../../domain/entities/earthquake/warning_zone_entity.dart';
import 'warning_zone_model.dart';

class TsunamiModel extends TsunamiEntity {
  const TsunamiModel({
    super.shakemap,
    super.wzmap,
    super.ttmap,
    super.ssmmap,
    super.warningZone,
  });

  factory TsunamiModel.fromJson(Map<String, dynamic> json) {
    return TsunamiModel(
      shakemap: json['shakemap'],
      wzmap: json['wzmap'],
      ttmap: json['ttmap'],
      ssmmap: json['sshmap'],
      warningZone: json.containsKey('wzarea')
          ? (json['wzarea']).map<WarningZoneModel>((e) => WarningZoneModel.fromJson(e)).toList()
          : null,
    );
  }

  factory TsunamiModel.fromEntity(TsunamiEntity entity) {
    return TsunamiModel(
      shakemap: entity.shakemap,
      wzmap: entity.wzmap,
      ttmap: entity.ttmap,
      ssmmap: entity.ssmmap,
      warningZone: entity.warningZone,
    );
  }

  TsunamiModel copyWith({
    String? subject,
    String? shakemap,
    String? wzmap,
    String? ttmap,
    String? ssmmap,
    List<WarningZoneEntity>? warningZone,
  }) {
    return TsunamiModel(
      shakemap: shakemap ?? this.shakemap,
      wzmap: wzmap ?? this.wzmap,
      ttmap: ttmap ?? this.ttmap,
      ssmmap: ssmmap ?? this.ssmmap,
      warningZone: warningZone ?? this.warningZone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shakemap': shakemap,
      'wzmap': wzmap,
      'ttmap': ttmap,
      'ssmmap': ssmmap,
      'warningZone': warningZone?.map((e) => e.toJson()),
    };
  }
}
