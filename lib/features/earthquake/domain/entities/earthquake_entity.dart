import 'package:equatable/equatable.dart';
import 'package:froom/froom.dart';
import 'package:latlong2/latlong.dart';

import 'earthquake_mmi_entity.dart';
import 'point_entity.dart';
import 'tsunami_entity.dart';

class EarthquakeEntity extends Equatable {
  final String? id;
  final String? event;
  final DateTime? time;
  @ignore
  final PointEntity? point;
  @ignore
  final List<EarthquakeMmiEntity>? earthquakeMMI;
  @ignore
  final TsunamiEntity? tsunamiData;
  final String? latitude;
  final String? longitude;
  final double? magnitude;
  final double? depth;
  final String? area;
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
    this.id,
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
      id,
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

  double? distanceTo(double? latitude, double? longitude) {
    if (latitude == null || longitude == null) return null;

    if (this.latitude == null || this.longitude == null) return null;

    final eqLat = double.tryParse(this.latitude!.split(' ').first);
    final eqLng = double.tryParse(this.longitude!.split(' ').first);

    if (eqLat == null || eqLng == null) return null;

    final meters = const Distance().distance(
      LatLng(latitude, longitude),
      LatLng(eqLat, eqLng),
    );

    final km = meters / 1000.0;

    return km;
  }

  bool get isFelt => felt != null;
}
