import 'package:equatable/equatable.dart';
import 'package:froom/froom.dart';

import 'warning_zone_entity.dart';

class TsunamiEntity extends Equatable {
  final String? id;
  final String? eventId;
  final String? shakemap;
  final String? wzmapUrl;
  final String? ttmapUrl;
  final String? sshmmapUrl;
  @ignore
  final List<WarningZoneEntity>? warningZone;

  const TsunamiEntity({
    this.id,
    this.eventId,
    this.shakemap,
    this.wzmapUrl,
    this.ttmapUrl,
    this.sshmmapUrl,
    this.warningZone,
  });

  @override
  List<Object?> get props {
    return [id, eventId, shakemap, wzmapUrl, ttmapUrl, sshmmapUrl, warningZone];
  }
}
