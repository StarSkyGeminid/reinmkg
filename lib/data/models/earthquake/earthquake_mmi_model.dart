
import '../../../domain/entities/earthquake/earthquake_mmi_entity.dart';

class EarthquakeMmiModel extends EarthquakeMmiEntity {
  const EarthquakeMmiModel({
    super.district,
    super.mmiMin,
    super.mmiMax,
    super.latitude,
    super.longitude,
  });

  factory EarthquakeMmiModel.fromJson(Map<String, dynamic> json) {
    final mmiMin = json['mmiMin'] is String?
        ? (json['mmiMin'] as String? ?? '')
        : (json['mmiMin'] ?? '');

    final mmiMax = json['mmiMax'] is String?
        ? (json['mmiMax'] as String? ?? '')
        : (json['mmiMax'] ?? '');

    if (json.containsKey('region')) {
      return EarthquakeMmiModel(
        district: json['region'],
        mmiMin: mmiMin.isValidRomanNumeralValue()
            ? mmiMin.toRomanNumeralValue()
            : null,
        mmiMax: mmiMax.isValidRomanNumeralValue()
            ? mmiMax.toRomanNumeralValue()
            : null,
      );
    }

    return EarthquakeMmiModel(
      district: json['district'],
      mmiMin: mmiMin,
      mmiMax: mmiMin,
    );
  }

  factory EarthquakeMmiModel.fromEntity(EarthquakeMmiEntity entity) {
    return EarthquakeMmiModel(
      district: entity.district,
      mmiMin: entity.mmiMin,
      mmiMax: entity.mmiMax,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  EarthquakeMmiModel copyWith({
    String? district,
    int? mmiMin,
    int? mmiMax,
    double? latitude,
    double? longitude,
  }) {
    return EarthquakeMmiModel(
      district: district ?? this.district,
      mmiMin: mmiMin ?? this.mmiMin,
      mmiMax: mmiMax ?? this.mmiMax,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'district': district,
      'mmiMin': mmiMin,
      'mmiMax': mmiMax,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
