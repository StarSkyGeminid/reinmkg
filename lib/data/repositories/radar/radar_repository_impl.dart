// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:rxdart/subjects.dart';

import 'package:reinmkg/core/error/failure.dart';
import 'package:reinmkg/domain/entities/weather/radar/radar_entity.dart';

import '../../../core/network/network_info.dart';
import '../../../domain/repositories/radar/radar_repository.dart';
import '../../datasources/remote/radar/remote_radar_service_datasource.dart';
import '../../models/weather/radar/radar_image_model.dart';
import '../../models/weather/radar/radar_model.dart';

class RadarRepositoryImpl implements RadarRepository {
  final RemoteRadarService _remoteRadarService;
  final NetworkInfo _networkInfo;

  final _selectedRadarStreamController = BehaviorSubject<RadarEntity>();

  List<RadarModel>? radars;

  RadarRepositoryImpl(
    this._remoteRadarService,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, RadarEntity>> getNearestRadarImage(
      LatLng location) async {
    if (!_networkInfo.isConnected) return Left(NoDataFailure());

    RadarModel? nearestRadar;

    if (radars != null) {
      nearestRadar = _getNearestRadar(radars!, location);
    } else {
      final allRadar = await _remoteRadarService.getRadars();

      allRadar.fold((l) => null, (r) {
        radars = r;

        nearestRadar = _getNearestRadar(r, location);
      });
    }

    if (nearestRadar?.code == null) return Left(NoDataFailure());

    return _getRadarImageByCode(nearestRadar!.code!).then((result) {
      return result.fold((l) => Left(l), (r) {
        final radar = nearestRadar?.copyWith(file: r);

        if (radar == null) return Left(NoDataFailure());

        _selectedRadarStreamController.add(radar);

        return Right(radar);
      });
    });
  }

  @override
  Future<Either<Failure, List<RadarEntity>>> getAllRadar() async {
    if (!_networkInfo.isConnected) return Left(NoDataFailure());

    final data = await _remoteRadarService.getRadars();

    return data.fold((l) => Left(l), (r) {
      radars = r;

      return Right(r);
    });
  }

  RadarModel _getNearestRadar(List<RadarModel> r, LatLng location) {
    RadarModel nearestRadar = r[0];

    double lastDistrance = 10000;

    Distance distance = const Distance();

    for (var e in r) {
      final far = distance.as(LengthUnit.Kilometer, location, e.position!);

      if (far < lastDistrance) {
        lastDistrance = far;

        nearestRadar = e;
      }
    }
    return nearestRadar;
  }

  @override
  void setSelected(RadarEntity data) {
    if (data.code == null) {
      return _selectedRadarStreamController.addError(NoDataFailure());
    }

    _getRadarImageByCode(data.code!).then((result) {
      result.fold((l) {
        _selectedRadarStreamController.addError(NoDataFailure());
      }, (r) {
        _selectedRadarStreamController
            .add(RadarModel.fromEntity(data).copyWith(file: r));
      });
    });
  }

  Future<Either<Failure, List<RadarImageModel>>> _getRadarImageByCode(
      String code) async {
    if (!_networkInfo.isConnected) return Left(NoDataFailure());

    return _remoteRadarService.getRadarImages(code).then((result) {
      return result.fold((l) => Left(l), (r) => Right(r));
    });
  }

  @override
  Stream<RadarEntity> stream() => _selectedRadarStreamController.stream;
}
