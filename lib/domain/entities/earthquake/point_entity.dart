import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:latlong2/latlong.dart';

import '../../../utils/utils.dart';

@TypeConverters([PointConverter])
class PointEntity extends Equatable {
  final double? latitude;
  final double? longitude;

  const PointEntity({this.latitude, this.longitude});

  LatLng? toLatLng() => latitude != null && longitude != null
      ? LatLng(latitude!, longitude!)
      : null;

  @override
  List<Object?> get props => [latitude, longitude];
}
