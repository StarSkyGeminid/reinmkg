import '../../domain/entities/location_entity.dart';
import 'administration_model.dart';

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
    super.time,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      administration: AdministrationModel.fromJson(
        json.containsKey('administration')
            ? json['administration'] as Map<String, dynamic>
            : json,
      ),
      vilage: json['desa'] ?? json['vilage'],
      subdistrict: json['kecamatan'] ?? json['subdistrict'],
      regency: json['kotkab'] ?? json['regency'],
      province: json['provinsi'] ?? json['province'],
      latitude: json.containsKey('lat') ? json['lat'] : json['latitude'],
      longitude: json.containsKey('lon') ? json['lon'] : json['longitude'],
      altitude: json.containsKey('alt') ? json['alt'] : json['altitude'],
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
      time: entity.time,
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
    DateTime? time,
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
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (administration != null)
        'administration': (administration as AdministrationModel).toJson(),
      'vilage': vilage,
      'subdistrict': subdistrict,
      'regency': regency,
      'province': province,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'time': time?.toIso8601String(),
    };
  }
}
