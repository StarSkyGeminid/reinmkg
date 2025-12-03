import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reinmkg/core/api/api.dart';

import '../../models/weather_nowcast_model.dart';

abstract class RemoteNowcastService {
  Future<List<WeatherNowcastModel>> getNowcasts();
}

class RemoteNowcastServiceImpl implements RemoteNowcastService {
  final Dio _dio = Dio();

  RemoteNowcastServiceImpl();

  @override
  Future<List<WeatherNowcastModel>> getNowcasts() async {
    try {
      final response = await _dio.get(ApiEndpoints.bmkgApp.nowcast);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final weatherData = response.data as List<dynamic>;

        return compute((jsonList) {
          final result = jsonList
              .map(
                (e) => WeatherNowcastModel.fromJson(e as Map<String, dynamic>),
              )
              .toList();

          return result;
        }, weatherData);
      }

      throw Exception('Failed to load nowcasts');
    } catch (e) {
      rethrow;
    }
  }
}
