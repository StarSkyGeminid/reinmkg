import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reinmkg/core/core.dart';

import '../../models/models.dart';

abstract class RemoteWeatherService {
  Future<WeatherModel> getCurrentWeather(String locationId);

  Future<List<WeatherModel>> getWeeklyWeather(String locationId);

  Future<List<DailyWeatherModel>> getDailyWeather(String locationId);
}

class RemoteWeatherServiceImpl implements RemoteWeatherService {
  final Dio _dio;

  RemoteWeatherServiceImpl(this._dio);

  @override
  Future<WeatherModel> getCurrentWeather(String locationId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.bmkgApp.currentWeather,
        queryParameters: {'adm4': locationId},
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        return WeatherModel.fromJson(response.data['data']['cuaca']);
      } else {
        throw Exception(
          'Server returned ${response.statusCode}: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error');
    }
  }

  @override
  Future<List<WeatherModel>> getWeeklyWeather(String locationId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.bmkgApp.forecasts,
        queryParameters: {'adm4': locationId},
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final weatherJson = response.data['data'][0]['cuaca'];

        return compute((weatherJson) {
          List<WeatherModel> models = [];
          for (var dayData in weatherJson) {
            for (var value in dayData) {
              models.add(WeatherModel.fromJson(value));
            }
          }

          return models;
        }, weatherJson);
      } else {
        throw Exception(
          'Server returned ${response.statusCode}: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error');
    }
  }

  @override
  Future<List<DailyWeatherModel>> getDailyWeather(String locationId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.bmkgApp.forecasts,
        queryParameters: {'adm4': locationId},
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final dailyWeatherJson = response.data['data'][0]['cuaca'];

        final weathers = await compute((dailyWeatherJson) {
          List<DailyWeatherModel> models = [];
          for (var value in dailyWeatherJson) {
            int weatherCode = 0;
            int maxTemp = value[0]['t'];
            int minTemp = value[0]['t'];

            value.forEach((values) {
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

            final weather = DailyWeatherModel(
              time: DateTime.tryParse(value[0]['datetime']),
              weather: weatherCode,
              maxTemp: maxTemp,
              minTemp: minTemp,
            );

            models.add(weather);
          }

          return models;
        }, dailyWeatherJson);

        return weathers.getRange(1, weathers.length).toList();
      } else {
        throw Exception(
          'Server returned ${response.statusCode}: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error');
    }
  }
}
