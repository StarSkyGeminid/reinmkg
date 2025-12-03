import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reinmkg/core/api/api_endpoinds.dart';

import '../../models/maritime_weather_model.dart';
import '../../models/water_wave_model.dart';

abstract class RemoteMaritimeWeatherService {
  Future<List<WaterWaveModel>> getWaterWaves();

  Future<List<MaritimeWeatherModel>> getWeatherDetails(String areaId);
}

class RemoteMaritimeWeatherServiceImpl implements RemoteMaritimeWeatherService {
  final Dio _dio = Dio();

  RemoteMaritimeWeatherServiceImpl();

  @override
  Future<List<WaterWaveModel>> getWaterWaves() async {
    try {
      final response = await _dio.get(ApiEndpoints.bmkgApp.waterWave);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final waterWave = response.data as Map<String, dynamic>;

        return compute((json) {
          final result = waterWave.entries.map((e) {
            return WaterWaveModel.fromJson({e.key: e.value});
          }).toList();

          return result;
        }, waterWave);
      } else {
        throw Exception(response.data['error'] as String?);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<MaritimeWeatherModel>> getWeatherDetails(String areaId) async {
    try {
      areaId = areaId.replaceAll(' ', '%20');

      final response = await _dio.get(
        ApiEndpoints.bmkgApp.maritimeWeather(areaId),
      );

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final weatherData = response.data['data'] as List<dynamic>;

        return compute((jsonList) {
          final result = jsonList
              .map(
                (e) => MaritimeWeatherModel.fromJson(e as Map<String, dynamic>),
              )
              .toList();

          return result;
        }, weatherData);
      } else {
        throw Exception(response.data['error'] as String?);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
