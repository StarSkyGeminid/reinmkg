// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/list_api.dart';
import '../../../../core/enumerate/radar_type.dart';
import '../../../../core/error/failure.dart';
import '../../../../utils/helper/common.dart';
import '../../../models/weather/radar/radar_image_model.dart';
import '../../../models/weather/radar/radar_model.dart';

extension on String {
  RadarType? toRadarType() {
    switch (toUpperCase()) {
      case 'QPF':
        return RadarType.qpf;
      case 'SRI':
        return RadarType.sri;
      case 'PAC06H':
        return RadarType.pac6;
      case 'CMAXSSA':
        return RadarType.cmaxssa;
      case 'PAC12H':
        return RadarType.pac12;
      case 'CAPPI010':
        return RadarType.cappi1;
      case 'CAPPI005':
        return RadarType.cappi05;
      case 'PAC24H':
        return RadarType.pac24;
      case 'CMAXHWIND':
        return RadarType.cmaxhwind;
      case 'CMAX':
        return RadarType.cmax;
      case 'PAC01H':
        return RadarType.pac1;
      default:
        return null;
    }
  }
}

abstract class RemoteRadarService {
  Future<Either<Failure, List<RadarModel>>> getRadars();

  Future<Either<Failure, List<RadarImageModel>>> getRadarImages(String code);
}

class RemoteRadarServiceImpl implements RemoteRadarService {
  final Dio _dio;

  RemoteRadarServiceImpl(this._dio);

  @override
  Future<Either<Failure, List<RadarImageModel>>> getRadarImages(
      String code) async {
    try {
      final response = await _dio.get(ListAPI.radarBmkg.radar(code));

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final radarJson = response.data;

        return compute((json) {
          List<RadarImageModel> images = [];

          log.d(json);

          json.keys.forEach((e) {
            final timeUtc = json[e]['LastOneHour']['timeUTC'];

            timeUtc.asMap().forEach((index, value) {
              images.add(RadarImageModel(
                file: json[e]['LastOneHour']['file'][index],
                time:
                    DateTime.tryParse(value.replaceAll(' UTC', 'Z'))?.toLocal(),
                type: (e as String).toRadarType(),
              ));
            });
          });

          return images;
        }, radarJson)
            .then((result) {
          return Right(result);
        });
      } else {
        return Left(
          ServerFailure(
            response.data['error'] as String?,
          ),
        );
      }
    } catch (e) {
      return Left(ServerFailure(
        e.toString(),
      ));
    }
  }

  @override
  Future<Either<Failure, List<RadarModel>>> getRadars() async {
    try {
      final response = await _dio.get(ListAPI.radarBmkg.radarMeta);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final weatherJson = response.data['datas'];
        log.d(weatherJson);

        return compute((json) {
          log.d(json);
          return json.map<RadarModel>((e) => RadarModel.fromJson(e)).toList();
        }, weatherJson)
            .then((result) => Right(result));
      } else {
        log.d('error');

        return Left(
          ServerFailure(
            response.data['error'] as String?,
          ),
        );
      }
    } catch (e) {
      log.e(e);
      return Left(ServerFailure(
        e.toString(),
      ));
    }
  }
}
