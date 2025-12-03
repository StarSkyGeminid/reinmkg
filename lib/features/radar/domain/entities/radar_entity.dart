import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class RadarEntity extends Equatable {
  final String? id;
  final String? code;
  final String? city;
  final String? station;
  final LatLng? position;
  final DateTime? time;
  final double? distance;
  final LatLng? tlc;
  final LatLng? brc;

  const RadarEntity({
    this.id,
    this.code,
    this.city,
    this.station,
    this.position,
    this.time,
    this.distance,
    this.tlc,
    this.brc,
  });

  @override
  List<Object?> get props {
    return [id, code, city, station, position, time, distance, tlc, brc];
  }
}
