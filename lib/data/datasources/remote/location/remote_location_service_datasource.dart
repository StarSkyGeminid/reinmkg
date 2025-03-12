import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../data.dart';

abstract class RemoteLocationService {
  Future<Either<Failure, LocationModel>> getNearestLocation(
      double latitude, double longitude);
}
