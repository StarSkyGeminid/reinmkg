import 'package:equatable/equatable.dart';

class EarthquakeMmiEntity extends Equatable {
  final String? id;
  final String? eventId;
  final String? district;
  final int? mmiMin;
  final int? mmiMax;
  final double? latitude;
  final double? longitude;

  const EarthquakeMmiEntity({
    this.id,
    this.eventId,
    this.district,
    this.mmiMin,
    this.mmiMax,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props {
    return [id, eventId, district, mmiMin, mmiMax, latitude, longitude];
  }
}
