// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import 'radar_image_entity.dart';

class RadarEntity extends Equatable {
  final String? id;
  final String? code;
  final String? city;
  final String? station;
  final LatLng? position;
  final DateTime? time;
  final List<RadarImageEntity>? file;
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
    this.file,
    this.distance,
    this.tlc,
    this.brc,
  });

  @override
  List<Object?> get props {
    return [
      id,
      code,
      city,
      station,
      position,
      time,
      file,
      distance,
      tlc,
      brc,
    ];
  }
}
