import 'dart:convert';

import '../../../../core/enumerate/radar_type.dart';
import '../../../../domain/entities/weather/radar/radar_image_entity.dart';

extension on String {
  RadarType? toRadarType() {
    switch (toUpperCase()) {
      case 'QPF':
        return RadarType.qpf;
      case 'SRI':
        return RadarType.sri;
      case 'PAC06H':
        return RadarType.pac6;
      case 'CMAXSSA':
        return RadarType.cmaxssa;
      case 'PAC12H':
        return RadarType.pac12;
      case 'CAPPI010':
        return RadarType.cappi1;
      case 'CAPPI005':
        return RadarType.cappi05;
      case 'PAC24H':
        return RadarType.pac24;
      case 'CMAXHWIND':
        return RadarType.cmaxhwind;
      case 'CMAX':
        return RadarType.cmax;
      case 'PAC01H':
        return RadarType.pac1;
      default:
        return null;
    }
  }
}

class RadarImageModel extends RadarImageEntity {
  const RadarImageModel({
    super.type,
    super.time,
    super.file,
  });

  RadarImageEntity copyWith({
    RadarType? type,
    DateTime? time,
    String? file,
  }) {
    return RadarImageEntity(
      type: type ?? this.type,
      time: time ?? this.time,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'time': time?.millisecondsSinceEpoch,
      'file': file,
    };
  }

  factory RadarImageModel.fromMap(Map<String, dynamic> map) {
    return RadarImageModel(
      type: map['type'] != null ? (map['type'] as String).toRadarType() : null,
      time: map['time'] != null ? DateTime.tryParse(map['time']) : null,
      file: map['file'] != null ? map['file'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RadarImageModel.fromJson(String source) =>
      RadarImageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
