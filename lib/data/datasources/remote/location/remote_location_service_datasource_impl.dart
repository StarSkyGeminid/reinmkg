import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:reinmkg/core/core.dart';

import '../../../data.dart';

class RemoteLocationServiceImpl implements RemoteLocationService {
  final Dio _dio;

  RemoteLocationServiceImpl(this._dio);

  @override
  Future<Either<Failure, LocationModel>> getNearestLocation(
      double latitude, double longitude) async {
    try {
      final response = await _dio.get(
        ListAPI.bmkgApp.currentCoordinateData,
        queryParameters: {
          'lon': double.parse(longitude.toStringAsPrecision(5)),
          'lat': double.parse(latitude.toStringAsPrecision(5)),
        },
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final location = LocationModel.fromJson(response.data);

        return Right(location);
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
}
