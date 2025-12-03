import 'package:equatable/equatable.dart';

class EarthquakePgaEntity extends Equatable {
  final String? stationId;
  final double? pga;
  final double? pgv;
  final double? pgd;
  final String? latitude;
  final String? longitude;
  final DateTime? timestamp;
  final int? mmi;
  final String? districtCode;

  const EarthquakePgaEntity({
    this.stationId,
    this.pga,
    this.pgv,
    this.pgd,
    this.latitude,
    this.longitude,
    this.timestamp,
    this.mmi,
    this.districtCode,
  });

  @override
  List<Object?> get props => [
    stationId,
    pga,
    pgv,
    pgd,
    latitude,
    longitude,
    timestamp,
    mmi,
    districtCode,
  ];
}
