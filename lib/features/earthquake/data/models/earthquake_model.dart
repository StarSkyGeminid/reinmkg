import 'package:froom/froom.dart';
import 'package:intl/intl.dart';
import 'package:reinmkg/core/utils/extension/datetime.dart';

import '../../domain/entities/earthquake_entity.dart';
import '../../domain/entities/point_entity.dart';
import '../../domain/entities/earthquake_mmi_entity.dart';
import '../../domain/entities/tsunami_entity.dart';
import 'earthquake_mmi_model.dart';
import 'point_model.dart';
import 'tsunami_model.dart';

@Entity(tableName: 'earthquake', primaryKeys: ['id'])
class EarthquakeModel extends EarthquakeEntity {
  @ignore
  final PointModel? _point;

  @ignore
  final List<EarthquakeMmiModel>? _earthquakeMMI;

  @ignore
  final TsunamiModel? _tsunamiData;

  @override
  PointEntity? get point => _point;

  @override
  List<EarthquakeMmiEntity>? get earthquakeMMI => _earthquakeMMI;

  @override
  TsunamiEntity? get tsunamiData => _tsunamiData;

  const EarthquakeModel({
    super.id,
    super.event,
    super.time,
    PointModel? point,
    List<EarthquakeMmiModel>? earthquakeMMI,
    TsunamiModel? tsunamiData,
    super.latitude,
    super.longitude,
    super.magnitude,
    super.depth,
    super.area,
    super.potential,
    super.subject,
    super.headline,
    super.description,
    super.instruction,
    super.shakemap,
    super.felt,
    super.timesent,
  }) : _point = point,
       _earthquakeMMI = earthquakeMMI,
       _tsunamiData = tsunamiData,
       super(point: null, earthquakeMMI: null, tsunamiData: null);

  static List<EarthquakeMmiModel> parseEarthquakeMmiList(
    String eventId,
    String input,
  ) {
    return input
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .map((s) => EarthquakeMmiModel.fromString(eventId, s))
        .toList();
  }

  factory EarthquakeModel.fromJson(Map<String, dynamic> json) {
    final time = DateFormat('dd-MM-yy HH:mm:ss').parse(
      '${(json['date'] as String).replaceAll(' WIB', '')} ${json['time'].split(' ')[0]}+0700',
    );

    return EarthquakeModel(
      event: json["event"],
      time: time,
      point: json["point"] == null ? null : PointModel.fromJson(json["point"]),
      earthquakeMMI: json.containsKey('felt') && json['felt'] != null
          ? parseEarthquakeMmiList(json["eventid"], json['felt'])
          : null,
      id: json["eventid"],
      tsunamiData: json.containsKey('wzmap')
          ? TsunamiModel.fromJson(json)
          : null,
      latitude: json["latitude"],
      longitude: json["longitude"],
      magnitude: double.parse(json["magnitude"]),
      depth: double.parse((json["depth"] as String).split(' ')[0]),
      area: json["area"],
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
      id: json["eventid"],
      event: json["event"],
      time: DateFormat('yyyy/MM/dd  HH:mm:ss.SSS').parse(json['waktu']),
      point: json["lintang"] == null ? null : PointModel.fromJson(json),
      latitude: json["latitude"],
      longitude: json["longitude"],
      magnitude: double.parse(json["mag"]),
      depth: double.parse((json["dalam"] as String).split(' ')[0]),
      area: json["area"],
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
      id: time?.toId(),
      time: time?.toLocal(),
      point: point,
      latitude: '${point?.latitude?.toStringAsFixed(2) ?? '-'} LS',
      longitude: '${point?.longitude?.toStringAsFixed(2) ?? '-'} BT',
      magnitude: double.parse(json['properties']["mag"]),
      depth: double.parse(json['properties']["depth"]),
      area: json['properties']["place"],
    );
  }

  factory EarthquakeModel.fromEntity(EarthquakeEntity entity) {
    return EarthquakeModel(
      event: entity.event,
      time: entity.time,
      id: entity.id,
      point: entity.point == null ? null : PointModel.fromEntity(entity.point!),
      earthquakeMMI: entity.earthquakeMMI
          ?.map((e) => EarthquakeMmiModel.fromEntity(e))
          .toList(),
      tsunamiData: entity.tsunamiData == null
          ? null
          : TsunamiModel.fromEntity(entity.tsunamiData!),
      latitude: entity.latitude,
      longitude: entity.longitude,
      magnitude: entity.magnitude,
      depth: entity.depth,
      area: entity.area,
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
    id: id,
    potential: potential,
    subject: subject,
    headline: headline,
    description: description,
    instruction: instruction,
    shakemap: shakemap,
    felt: felt,
    timesent: timesent,
  );

  EarthquakeModel copyWith({
    String? id,
    String? event,
    DateTime? time,
    PointEntity? point,
    List<EarthquakeMmiEntity>? earthquakeMMI,
    TsunamiEntity? tsunamiData,
    String? latitude,
    String? longitude,
    double? magnitude,
    double? depth,
    String? area,
    String? potential,
    String? subject,
    String? headline,
    String? description,
    String? instruction,
    String? shakemap,
    String? felt,
    String? timesent,
  }) {
    return EarthquakeModel(
      id: id ?? this.id,
      event: event ?? this.event,
      time: time ?? this.time,
      point: point != null
          ? (point is PointModel ? point : PointModel.fromEntity(point))
          : _point,
      earthquakeMMI: earthquakeMMI != null
          ? earthquakeMMI
                .map(
                  (e) => e is EarthquakeMmiModel
                      ? e
                      : EarthquakeMmiModel.fromEntity(e),
                )
                .toList()
          : _earthquakeMMI,
      tsunamiData: tsunamiData != null
          ? (tsunamiData is TsunamiModel
                ? tsunamiData
                : TsunamiModel.fromEntity(tsunamiData))
          : _tsunamiData,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      magnitude: magnitude ?? this.magnitude,
      depth: depth ?? this.depth,
      area: area ?? this.area,
      potential: potential ?? this.potential,
      subject: subject ?? this.subject,
      headline: headline ?? this.headline,
      description: description ?? this.description,
      instruction: instruction ?? this.instruction,
      shakemap: shakemap ?? this.shakemap,
      felt: felt ?? this.felt,
      timesent: timesent ?? this.timesent,
    );
  }
}
