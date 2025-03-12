import 'package:reinmkg/data/models/location/administration_model.dart';

import '../../../domain/entities/location/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    super.administration,
    super.vilage,
    super.subdistrict,
    super.regency,
    super.province,
    super.latitude,
    super.longitude,
    super.altitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> map) {
    return LocationModel(
      administration: AdministrationModel.fromJson(map),
      vilage: map['desa'] ?? map['vilage'],
      subdistrict: map['kecamatan'] ?? map['subdistric'],
      regency: map['kotkab'] ?? map['regency'],
      province: map['provinsi'] ?? map['province'],
      latitude: map.containsKey('lat') ? map['lat'] : map['latitude'],
      longitude: map.containsKey('lon') ? map['lon'] : map['longitude'],
      altitude: map.containsKey('alt') ? map['alt'] : map['altitude'],
    );
  }

  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      administration: entity.administration,
      vilage: entity.vilage,
      subdistrict: entity.subdistrict,
      regency: entity.regency,
      province: entity.province,
      latitude: entity.latitude,
      longitude: entity.longitude,
      altitude: entity.altitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (administration != null)
        ...AdministrationModel.fromEntity(administration!).toJson(),
      'vilage': vilage,
      'subdistric': subdistrict,
      'regency': regency,
      'province': province,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
    };
  }

  LocationEntity get toEntity {
    return LocationModel(
      administration: administration,
      vilage: vilage,
      subdistrict: subdistrict,
      regency: regency,
      province: province,
      latitude: latitude,
      longitude: longitude,
      altitude: altitude,
    );
  }

  LocationModel copyWith({
    AdministrationModel? administration,
    String? vilage,
    String? subdistrict,
    String? regency,
    String? province,
    double? latitude,
    double? longitude,
    double? altitude,
  }) {
    return LocationModel(
      administration: administration ?? this.administration,
      vilage: vilage ?? this.vilage,
      subdistrict: subdistrict ?? this.subdistrict,
      regency: regency ?? this.regency,
      province: province ?? this.province,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
    );
  }
}
