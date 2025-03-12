import 'package:floor/floor.dart';
import 'package:intl/intl.dart';
import 'package:numerus/numerus.dart';
import 'package:reinmkg/data/models/earthquake/tsunami_model.dart';
import 'package:reinmkg/utils/ext/datetime.dart';

import '../../../domain/domain.dart';
import 'earthquake_mmi_model.dart';
import 'point_model.dart';

@Entity(tableName: 'earthquake', primaryKeys: ['eventid'])
class EarthquakeModel extends EarthquakeEntity {
  const EarthquakeModel({
    super.event,
    super.time,
    super.point,
    super.earthquakeMMI,
    super.tsunamiData,
    super.latitude,
    super.longitude,
    super.magnitude,
    super.depth,
    super.area,
    super.eventid,
    super.potential,
    super.subject,
    super.headline,
    super.description,
    super.instruction,
    super.shakemap,
    super.felt,
    super.timesent,
  });

  static List<EarthquakeMmiModel> parseEarthquakeMmiList(String input) {
    return input
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .map(parseEarthquakeMmiSingle)
        .toList();
  }

  static EarthquakeMmiModel parseEarthquakeMmiSingle(String input) {
    const romawi = r'(?:I|V|X){1,4}';

    // Mencoba match dengan berbagai pattern
    final match = RegExp(
            // District MMI-MMI | MMI-MMI District | MMI District | District MMI
            r'^(?:(romawi)\s*-\s*(romawi)\s+(.+)|(.+?)\s+(romawi)\s*-\s*(romawi)|(romawi)\s+(.+)|(.+?)\s+(romawi))$'
                .replaceAll('romawi', romawi))
        .firstMatch(input);

    // MMI-MMI District
    if (match != null) {
      if (match.group(1) != null) {
        return EarthquakeMmiModel(
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
          district: match.group(9)!,
          mmiMin: match.group(10)!.isValidRomanNumeralValue()
              ? match.group(10)!.toRomanNumeralValue()
              : null,
          mmiMax: match.group(10)!.isValidRomanNumeralValue()
              ? match.group(10)!.toRomanNumeralValue()
              : null,
        );
      }

      // if (match.group(1) != null && match.group(2) != null) {
      //   final isFlipped = match.group(1)!.isValidRomanNumeralValue();

      //   String mmiMin = isFlipped ? match.group(1)! : match.group(1)!;
      //   String mmiMax = match.group(2)!;
      //   String district = match.group(3)!.trim();
      //   return EarthquakeMmiModel(
      //     mmiMin: mmiMin.isValidRomanNumeralValue()
      //         ? mmiMin.toRomanNumeralValue()
      //         : null,
      //     mmiMax: mmiMax.isValidRomanNumeralValue()
      //         ? mmiMax.toRomanNumeralValue()
      //         : null,
      //     district: district,
      //   );
      // } else if (match.group(4) != null) {
      //   final isFlipped = match.group(4)!.isValidRomanNumeralValue();

      //   String mmiMin = isFlipped ? match.group(4)! : match.group(5)!;
      //   String mmiMax = mmiMin;
      //   String district =
      //       isFlipped ? match.group(5)!.trim() : match.group(4)!.trim();
      //   return EarthquakeMmiModel(
      //     mmiMin: mmiMin.isValidRomanNumeralValue()
      //         ? mmiMin.toRomanNumeralValue()
      //         : null,
      //     mmiMax: mmiMax.isValidRomanNumeralValue()
      //         ? mmiMax.toRomanNumeralValue()
      //         : null,
      //     district: district,
      //   );
      // }
    }
    return EarthquakeMmiModel(
      district: input,
    );
  }

  factory EarthquakeModel.fromJson(Map<String, dynamic> json) {
    final time = DateFormat('dd-MM-yy HH:mm:ss').parse(
        '${(json['date'] as String).replaceAll(' WIB', '')} ${json['time'].split(' ')[0]}+0700');

    return EarthquakeModel(
      event: json["event"],
      time: time,
      point: json["point"] == null ? null : PointModel.fromJson(json["point"]),
      earthquakeMMI:
          json.containsKey('felt') && json['felt']
          != null ? parseEarthquakeMmiList(json['felt']) : null,
      tsunamiData:
          json.containsKey('wzmap') ? TsunamiModel.fromJson(json) : null,
      latitude: json["latitude"],
      longitude: json["longitude"],
      magnitude: double.parse(json["magnitude"]),
      depth: double.parse((json["depth"] as String).split(' ')[0]),
      area: json["area"],
      eventid: json["eventid"],
      potential: json["potential"],
      subject: json["subject"],
      headline: json["headline"],
      description: json["description"],
      instruction: json["instruction"],
      shakemap: json["shakemap"],
      felt: json["felt"],
      timesent: json["timesent"],
    );
  }

  factory EarthquakeModel.fromLiveJson(Map<String, dynamic> json) {
    return EarthquakeModel(
      event: json["event"],
      time: DateFormat('yyyy/MM/dd  HH:mm:ss.SSS').parse(json['waktu']),
      point: json["lintang"] == null ? null : PointModel.fromJson(json),
      latitude: json["latitude"],
      longitude: json["longitude"],
      magnitude: double.parse(json["mag"]),
      depth: double.parse((json["dalam"] as String).split(' ')[0]),
      area: json["area"],
      eventid: json["eventid"],
      potential: json["potential"],
      subject: json["subject"],
      headline: json["headline"],
      description: json["description"],
      instruction: json["instruction"],
      shakemap: json["shakemap"],
      felt: json["felt"],
      timesent: json["timesent"],
    );
  }

  factory EarthquakeModel.fromQLJson(Map<String, dynamic> json) {
    var point = json["geometry"] == null
        ? null
        : PointModel.fromRealtimeJson(json["geometry"]);

    var time = DateTime.tryParse('${json['properties']['time']}z');

    return EarthquakeModel(
      time: time?.toLocal(),
      point: point,
      latitude: '${point?.latitude?.toStringAsFixed(2) ?? '-'} LS',
      longitude: '${point?.longitude?.toStringAsFixed(2) ?? '-'} BT',
      magnitude: double.parse(json['properties']["mag"]),
      depth: double.parse(json['properties']["depth"]),
      area: json['properties']["place"],
      eventid: time?.toId(),
    );
  }

  factory EarthquakeModel.fromEntity(EarthquakeEntity entity) {
    return EarthquakeModel(
      event: entity.event,
      time: entity.time,
      point: entity.point,
      earthquakeMMI: entity.earthquakeMMI,
      tsunamiData: entity.tsunamiData,
      latitude: entity.latitude,
      longitude: entity.longitude,
      magnitude: entity.magnitude,
      depth: entity.depth,
      area: entity.area,
      eventid: entity.eventid,
      potential: entity.potential,
      subject: entity.subject,
      headline: entity.headline,
      description: entity.description,
      instruction: entity.instruction,
      shakemap: entity.shakemap,
      felt: entity.felt,
      timesent: entity.timesent,
    );
  }

  EarthquakeEntity get toEntity => EarthquakeEntity(
        event: event,
        time: time,
        point: point,
        earthquakeMMI: earthquakeMMI,
        tsunamiData: tsunamiData,
        latitude: latitude,
        longitude: longitude,
        magnitude: magnitude,
        depth: depth,
        area: area,
        eventid: eventid,
        potential: potential,
        subject: subject,
        headline: headline,
        description: description,
        instruction: instruction,
        shakemap: shakemap,
        felt: felt,
        timesent: timesent,
      );
}
