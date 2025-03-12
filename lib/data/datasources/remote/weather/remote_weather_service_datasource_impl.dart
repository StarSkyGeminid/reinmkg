import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reinmkg/core/core.dart';

import '../../../data.dart';

class RemoteWeatherServiceImpl implements RemoteWeatherService {
  final Dio _dio;

  RemoteWeatherServiceImpl(this._dio);

  @override
  Future<Either<Failure, WeatherModel>> getCurrentWeather(
      String locationId) async {
    try {
      final response = await _dio.get(
        ListAPI.bmkgApp.currentWeather,
        queryParameters: {
          'adm4': locationId,
        },
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        return Right(WeatherModel.fromJson(response.data['data']['cuaca']));
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
  Future<Either<Failure, List<WeatherModel>>> getWeeklyWeathers(
      String locationId) async {
    try {
      final response = await _dio.get(
        ListAPI.bmkgApp.forecasts,
        queryParameters: {
          'adm4': locationId,
        },
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final weatherJson = response.data['data'][0]['cuaca'];

        return compute((json) {
          List<WeatherModel> models = [];

          json.forEach((e) {
            e.forEach((value) {
              models.add(WeatherModel.fromJson(value));
            });
          });

          return models;
        }, weatherJson)
            .then((result) => Right(result));
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
  Future<Either<Failure, List<DailyWeatherModel>>> getDailyWeathers(
      String locationId) async {
    try {
      final response = await _dio.get(
        ListAPI.bmkgApp.forecasts,
        queryParameters: {
          'adm4': locationId,
        },
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final weatherJson = response.data['data'][0]['cuaca'];

        return compute((json) {
          return weatherJson.map<DailyWeatherModel>((e) {
            int weatherCode = 0;
            int maxTemp = e[0]['t'];
            int minTemp = e[0]['t'];

            e.forEach((values) {
              if (values['weather'] as int > weatherCode) {
                weatherCode = values['weather'];
              }

              if (values['t'] as int > maxTemp) {
                maxTemp = values['t'];
              }

              if (values['t'] as int < minTemp) {
                minTemp = values['t'];
              }
            });

            return DailyWeatherModel(
              time: DateTime.tryParse(e[0]['datetime']),
              weather: weatherCode,
              maxTemp: maxTemp,
              minTemp: minTemp,
            );
          }).toList();
        }, weatherJson)
            .then((result) => Right(result));
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
  Future<Either<Failure, List<String>>> getSateliteImages() async {
    try {
      final response = await _dio.get(ListAPI.bmkgApp.sateliteImage);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final List<String> images = List<String>.from(response.data['data']);

        final addedLink = images
            .map(
              (e) => 'https://api-app.devbmkg.my.id/storage/satelit/$e',
            )
            .toList();

        return Right(addedLink);
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
  Future<Either<Failure, List<WaterWaveModel>>> getWaterWaves() async {
    try {
      final response = await _dio.get(ListAPI.bmkgApp.waterWave);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final waterWave = response.data as Map<String, dynamic>;

        return compute((json) {
          final result = waterWave.entries.map((e) {
            return WaterWaveModel.fromJson({e.key: e.value});
          }).toList();

          return Right(result);
        }, waterWave);
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
