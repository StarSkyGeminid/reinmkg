import 'package:froom/froom.dart';

import '../../domain/entities/point_entity.dart';
import 'earthquake_model.dart';

@Entity(
  tableName: 'point',
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
class PointModel extends PointEntity {
  const PointModel({super.id, super.eventId, super.latitude, super.longitude});

  factory PointModel.fromJson(Map<String, dynamic> json) {
    final containCoordinate = json.containsKey('coordinates');

    if (containCoordinate) {
      String coordinate = json['coordinates'];

      return PointModel(
        latitude: double.parse(coordinate.split(',')[1]),
        longitude: double.parse(coordinate.split(',')[0]),
      );
    } else {
      return PointModel(
        latitude: double.parse(json['lintang']),
        longitude: double.parse(json['bujur']),
      );
    }
  }

  factory PointModel.fromRealtimeJson(Map<String, dynamic> json) {
    var coordinate = json['coordinates'];

    return PointModel(
      latitude: double.parse(coordinate[1]),
      longitude: double.parse(coordinate[0]),
    );
  }

  PointModel copyWith({double? latitiude, double? longitude}) => PointModel(
    latitude: latitude ?? this.longitude,
    longitude: longitude ?? this.longitude,
  );

  Map<String, dynamic> toJson() {
    return {'coordinates': '$latitude, $longitude'};
  }

  factory PointModel.fromEntity(PointEntity value) {
    return PointModel(latitude: value.latitude, longitude: value.longitude);
  }
}
