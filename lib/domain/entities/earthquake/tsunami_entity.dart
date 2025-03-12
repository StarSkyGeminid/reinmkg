import 'package:equatable/equatable.dart';
import 'package:reinmkg/domain/entities/earthquake/warning_zone_entity.dart';

class TsunamiEntity extends Equatable {
  final String? shakemap;
  final String? wzmap;
  final String? ttmap;
  final String? ssmmap;
  final List<WarningZoneEntity>? warningZone;

  const TsunamiEntity({
    this.shakemap,
    this.wzmap,
    this.ttmap,
    this.ssmmap,
    this.warningZone,
  });

  @override
  List<Object?> get props {
    return [
      shakemap,
      wzmap,
      ttmap,
      ssmmap,
      warningZone,
    ];
  }
}
