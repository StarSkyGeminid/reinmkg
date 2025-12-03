import '../../domain/entities/earthquake_pga_entity.dart';

class EarthquakePgaModel extends EarthquakePgaEntity {
  const EarthquakePgaModel({
    super.stationId,
    super.pga,
    super.pgv,
    super.pgd,
    super.latitude,
    super.longitude,
    super.timestamp,
    super.mmi,
    super.districtCode,
  });

  factory EarthquakePgaModel.fromJson(Map<String, dynamic> json) {
    final tsValue = json['timestamp'];
    DateTime? timestamp;
    if (tsValue != null) {
      double? seconds;
      if (tsValue is String) {
        seconds = double.tryParse(tsValue);
      } else if (tsValue is num) {
        seconds = tsValue.toDouble();
      }
      if (seconds != null) {
        final millis = (seconds * 1000).round();
        timestamp = DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);
      }
    }

    return EarthquakePgaModel(
      stationId: json['kode'] as String?,
      pga: (json['pga'] as num?)?.toDouble(),
      pgv: (json['pgv'] as num?)?.toDouble(),
      pgd: (json['pgd'] as num?)?.toDouble(),
      latitude: (json['lat'] as num?)?.toString(),
      longitude: (json['lon'] as num?)?.toString(),
      timestamp: timestamp,
      mmi: json['mmi'] as int?,
      districtCode: json['kab'] as String?,
    );
  }
}
