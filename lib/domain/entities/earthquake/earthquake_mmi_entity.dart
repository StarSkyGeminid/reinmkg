import 'package:equatable/equatable.dart';

class EarthquakeMmiEntity extends Equatable {
  final String? district;
  final int? mmiMin;
  final int? mmiMax;
  final double? latitude;
  final double? longitude;

  const EarthquakeMmiEntity({
    this.district,
    this.mmiMin,
    this.mmiMax,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props {
    return [
      district,
      mmiMin,
      mmiMax,
      latitude,
      longitude,
    ];
  }
}
