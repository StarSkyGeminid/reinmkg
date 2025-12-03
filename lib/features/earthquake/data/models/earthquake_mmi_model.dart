import 'package:froom/froom.dart';
import 'package:numerus/numerus.dart';

import '../../domain/entities/earthquake_mmi_entity.dart';
import 'earthquake_model.dart';

@Entity(
  tableName: 'earthquakeMmi',
  primaryKeys: ['id'],
  foreignKeys: [
    ForeignKey(
      entity: EarthquakeModel,
      parentColumns: ['id'],
      childColumns: ['eventId'],
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class EarthquakeMmiModel extends EarthquakeMmiEntity {
  const EarthquakeMmiModel({
    super.id,
    super.eventId,
    super.district,
    super.mmiMin,
    super.mmiMax,
    super.latitude,
    super.longitude,
  });

  factory EarthquakeMmiModel.fromString(String eventId, String input) {
    const roman = r'(?:I|V|X){1,4}';

    final match = RegExp(
      r'^(?:(roman)\s*-\s*(roman)\s+(.+)|(.+?)\s+(roman)\s*-\s*(roman)|(roman)\s+(.+)|(.+?)\s+(roman))$'
          .replaceAll('roman', roman),
    ).firstMatch(input);

    // MMI-MMI District
    if (match != null) {
      if (match.group(1) != null) {
        return EarthquakeMmiModel(
          id: '$eventId-${match.group(3)}',
          eventId: eventId,
          district: match.group(3)!,
          mmiMin: match.group(1)!.isValidRomanNumeralValue()
              ? match.group(1)!.toRomanNumeralValue()
              : null,
          mmiMax: match.group(2)!.isValidRomanNumeralValue()
              ? match.group(2)!.toRomanNumeralValue()
              : null,
        );
      }
      // District MMI-MMI
      else if (match.group(4) != null) {
        return EarthquakeMmiModel(
          id: '$eventId-${match.group(4)}',
          eventId: eventId,
          district: match.group(4)!,
          mmiMin: match.group(5)!.isValidRomanNumeralValue()
              ? match.group(5)!.toRomanNumeralValue()
              : null,
          mmiMax: match.group(6)!.isValidRomanNumeralValue()
              ? match.group(6)!.toRomanNumeralValue()
              : null,
        );
      }
      // MMI District
      else if (match.group(7) != null) {
        return EarthquakeMmiModel(
          id: '$eventId-${match.group(8)}',
          eventId: eventId,
          district: match.group(8)!,
          mmiMin: match.group(7)!.isValidRomanNumeralValue()
              ? match.group(7)!.toRomanNumeralValue()
              : null,
          mmiMax: match.group(7)!.isValidRomanNumeralValue()
              ? match.group(7)!.toRomanNumeralValue()
              : null,
        );
      }
      // District MMI
      else {
        return EarthquakeMmiModel(
          id: '$eventId-${match.group(9)}',
          eventId: eventId,
          district: match.group(9)!,
          mmiMin: match.group(10)!.isValidRomanNumeralValue()
              ? match.group(10)!.toRomanNumeralValue()
              : null,
          mmiMax: match.group(10)!.isValidRomanNumeralValue()
              ? match.group(10)!.toRomanNumeralValue()
              : null,
        );
      }
    }
    return EarthquakeMmiModel(district: input);
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
