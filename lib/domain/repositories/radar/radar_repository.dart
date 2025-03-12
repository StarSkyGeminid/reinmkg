import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:reinmkg/core/error/failure.dart';

import '../../entities/weather/radar/radar_entity.dart';
import '../base/base_selectable_data.dart';

abstract class RadarRepository extends BaseSelectableData<RadarEntity> {
  Future<Either<Failure, RadarEntity>> getNearestRadarImage(LatLng location);
}
