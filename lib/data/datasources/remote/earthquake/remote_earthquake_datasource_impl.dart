import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:xml2json/xml2json.dart';

import '../../../../core/core.dart';
import '../../../models/models.dart';
import 'remote_earthquake_datasource.dart';

class RemoteEarthquakeServiceImpl implements RemoteEarthquakeService {
  final Dio _dio = Dio();

  RemoteEarthquakeServiceImpl();

  @override
  Future<Either<Failure, EarthquakeModel>> getLastEarthquakeFelt() {
    try {
      return _dio.get(ListAPI.inaTews.lastEarthquakeFelt).then((response) {
        if (response.statusCode == HttpStatus.ok && response.data != null) {
          final earthquake = EarthquakeModel.fromJson(response.data['info']);

          return Right(earthquake);
        } else {
          return Left(ServerFailure(response.statusMessage));
        }
      });
    } catch (e) {
      return Future.value(Left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, EarthquakeModel>> getRecentEarthquake() {
    try {
      return _dio.get(ListAPI.inaTews.recentEarthquake).then((response) {
        if (response.statusCode == HttpStatus.ok && response.data != null) {
          final earthquake =
              EarthquakeModel.fromQLJson(response.data['features'][0]);

          return Right(earthquake);
        } else {
          return Left(ServerFailure(response.statusMessage));
        }
      });
    } on DioException catch (e) {
      return Future.value(Left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EarthquakeModel>>> getOneWeekEarthquake() async {
    try {
      final response = await _dio.get(
        ListAPI.inaTews.oneWeekEarthquakes,
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final json = response.data['features'];

        return compute((json) {
          List<EarthquakeModel> earthquakes = [];

          for (var element in json) {
            earthquakes.add(
              EarthquakeModel.fromQLJson(element),
            );
          }
          return earthquakes;
        }, json)
            .then((List<EarthquakeModel> value) => Right(value));
      } else {
        return Left(ServerFailure(response.statusMessage));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EarthquakeModel>>>
      getListEarthquakesFelt() async {
    final xmlToJson = Xml2Json();

    try {
      final response = await _dio.get(
        ListAPI.inaTews.earthquakesFelt,
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        xmlToJson.parse(response.data);

        return compute(jsonDecode, xmlToJson.toParker()).then((value) {
          return _parseEarthquakeData(value);
        });
      } else {
        return Left(ServerFailure(response.statusMessage));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EarthquakeModel>>> getEarthquakesByType(
      EarthquakesType type) async {
    final xmlToJson = Xml2Json();

    try {
      final response = await _dio.get(
        ListAPI.inaTews.fromEarthquakesType(type),
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        xmlToJson.parse(response.data);

        return compute(jsonDecode, xmlToJson.toParker()).then((value) {
          return _parseEarthquakeData(value);
        });
      } else {
        return Left(ServerFailure(response.statusMessage));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Either<Failure, List<EarthquakeModel>> _parseEarthquakeData(
      Map<String, dynamic> json) {
    try {
      List<EarthquakeModel> earthquakes = [];

      final containAlert = json.containsKey('alert');

      var containsStatus =
          (containAlert ? json['alert'] : json).containsKey('status');

      final isActual = containsStatus &&
          ((containAlert ? json['alert'] : json)['status'] as String)
                  .toLowerCase() ==
              'actual';

      if (isActual) {
        for (var element in json['alert']['info']) {
          earthquakes.add(
            EarthquakeModel.fromJson(element),
          );
        }
      } else if (json.containsKey('Infogempa')) {
        for (var element in json['Infogempa']['gempa']) {
          earthquakes.add(
            EarthquakeModel.fromLiveJson(element),
          );
        }
      } else {
        return Left(NoDataFailure());
      }

      return Right(earthquakes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
