import '../../domain/entities/radar_image_entity.dart';
import '../../domain/enumerate/radar_type.dart';

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

  const RadarImageModel({super.file, super.time, super.type});

  factory RadarImageModel.fromMap(
    Map<String, dynamic> map,
    RadarType type,
    int index,
  ) {
    final timeUtc = map['LastOneHour']['timeUTC'];
    final fileList = map['LastOneHour']['file'];
    final value = timeUtc is List ? timeUtc[index] : null;
    final file = (fileList is List && index < fileList.length)
        ? fileList[index] as String
        : '';
    return RadarImageModel(
      file: file,
      time: value != null
          ? DateTime.tryParse(value.replaceAll(' UTC', 'Z'))?.toLocal()
          : null,
      type: type,
    );
  }
}

List<RadarImageModel> parseRadarImages(Map<String, dynamic> json) {
  final images = <RadarImageModel>[];

  for (var key in json.keys) {
    final bucket = json[key];
    if (bucket == null) continue;

    final lastOneHour = bucket['LastOneHour'];
    if (lastOneHour == null) continue;

    final timeUtc = lastOneHour['timeUTC'];
    final files = lastOneHour['file'];

    if (timeUtc is List && files is List) {
      for (var i = 0; i < timeUtc.length && i < files.length; i++) {
        final timeStr = timeUtc[i] as String?;
        final fileStr = files[i] as String?;
        images.add(
          RadarImageModel(
            file: fileStr ?? '',
            time: timeStr != null
                ? DateTime.tryParse(timeStr.replaceAll(' UTC', 'Z'))?.toLocal()
                : null,
            type: (key).toRadarType(),
          ),
        );
      }
    }
  }

  return images;
}
