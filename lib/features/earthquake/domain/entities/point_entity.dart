import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class PointEntity extends Equatable {
  final String? id;
  final String? eventId;
  final double? latitude;
  final double? longitude;

  const PointEntity({this.id, this.eventId, this.latitude, this.longitude});

  LatLng? toLatLng() => latitude != null && longitude != null
      ? LatLng(latitude!, longitude!)
      : null;

  @override
  List<Object?> get props => [id, eventId, latitude, longitude];
}
