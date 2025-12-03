import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/radar_entity.dart';

class RadarModel extends RadarEntity {
  const RadarModel({
    super.id,
    super.city,
    super.station,
    super.position,
    super.time,
    super.distance,
    super.code,
    super.tlc,
    super.brc,
  });

  factory RadarModel.fromJson(Map<String, dynamic> json) {
    final timeRaw =
        json.containsKey('CMAX') && json['CMAX'].containsKey('timeUTC')
        ? (json['CMAX']['timeUTC'] as String?)
        : null;
    final time = timeRaw != null
        ? DateFormat(
            'yyyy-MM-dd HH:mm',
          ).tryParse(timeRaw.replaceAll(' UTC', ''), true)
        : null;

    return RadarModel(
      id: json['kode'],
      city: json['Kota'],
      station: json['Stasiun'],
      position: LatLng(json['lat'], json['lon']),
      time: time,
      distance: json.containsKey('jarak')
          ? double.tryParse(json['jarak'])
          : null,
      code: json['kode'],
      tlc: LatLng(
        double.parse(json['overlayTLC'][0] as String),
        double.parse(json['overlayTLC'][1] as String),
      ),
      brc: LatLng(
        double.parse(json['overlayBRC'][0] as String),
        double.parse(json['overlayBRC'][1] as String),
      ),
    );
  }

  factory RadarModel.fromEntity(RadarEntity entity) {
    return RadarModel(
      id: entity.id,
      city: entity.city,
      station: entity.station,
      position: entity.position,
      time: entity.time,
      distance: entity.distance,
      code: entity.code,
      tlc: entity.tlc,
      brc: entity.brc,
    );
  }

  RadarModel copyWith({
    String? id,
    String? kota,
    String? station,
    LatLng? position,
    DateTime? time,
    double? distance,
    String? code,
    LatLng? tlc,
    LatLng? brc,
  }) {
    return RadarModel(
      id: id ?? this.id,
      city: kota ?? city,
      station: station ?? this.station,
      position: position ?? this.position,
      time: time ?? this.time,
      distance: distance ?? this.distance,
      code: code ?? this.code,
      tlc: tlc ?? this.tlc,
      brc: brc ?? this.brc,
    );
  }
}
