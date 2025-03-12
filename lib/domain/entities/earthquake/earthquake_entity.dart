import 'package:equatable/equatable.dart';

import 'earthquake_mmi_entity.dart';
import 'point_entity.dart';
import 'tsunami_entity.dart';

class EarthquakeEntity extends Equatable {
  final String? event;
  final DateTime? time;
  final PointEntity? point;
  final List<EarthquakeMmiEntity>? earthquakeMMI;
  final TsunamiEntity? tsunamiData;
  final String? latitude;
  final String? longitude;
  final double? magnitude;
  final double? depth;
  final String? area;
  final String? eventid;
  final String? potential;
  final String? subject;
  final String? headline;
  final String? description;
  final String? instruction;
  final String? shakemap;
  final String? felt;
  final String? timesent;

  const EarthquakeEntity({
    this.event,
    required this.time,
    this.point,
    this.earthquakeMMI,
    this.tsunamiData,
    this.latitude,
    this.longitude,
    this.magnitude,
    this.depth,
    this.area,
    this.eventid,
    this.potential,
    this.subject,
    this.headline,
    this.description,
    this.instruction,
    this.shakemap,
    this.felt,
    this.timesent,
  });

  @override
  List<Object?> get props {
    return [
      event,
      time,
      point,
      earthquakeMMI,
      tsunamiData,
      latitude,
      longitude,
      magnitude,
      depth,
      area,
      eventid,
      potential,
      subject,
      headline,
      description,
      instruction,
      shakemap,
      felt,
      timesent,
    ];
  }
}
