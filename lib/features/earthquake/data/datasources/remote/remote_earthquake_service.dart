import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reinmkg/core/api/api_endpoinds.dart';
import 'package:xml2json/xml2json.dart';

import '../../../domain/enumerates/earthquakes_type.dart';
import '../../models/earthquake_model.dart';

abstract class RemoteEarthquakeService {
  Future<EarthquakeModel> getLastEarthquakeFelt();

  Future<EarthquakeModel> getRecentEarthquake();

  Future<List<EarthquakeModel>> getOneWeekEarthquake();

  Future<List<EarthquakeModel>> getListEarthquakesFelt();

  Future<List<EarthquakeModel>> getEarthquakesByType(EarthquakesType type);
}

class RemoteEarthquakeServiceImpl implements RemoteEarthquakeService {
  final Dio _dio = Dio();

  RemoteEarthquakeServiceImpl();

  @override
  Future<EarthquakeModel> getLastEarthquakeFelt() {
    try {
      return _dio.get(ApiEndpoints.inaTews.lastEarthquakeFelt).then((response) {
        if (response.statusCode == HttpStatus.ok && response.data != null) {
          final earthquake = EarthquakeModel.fromJson(response.data['info']);

          return earthquake;
        } else {
          throw Exception(response.statusMessage);
        }
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<EarthquakeModel> getRecentEarthquake() {
    try {
      return _dio.get(ApiEndpoints.inaTews.recentEarthquake).then((response) {
        if (response.statusCode == HttpStatus.ok && response.data != null) {
          final earthquake = EarthquakeModel.fromQLJson(
            response.data['features'][0],
          );

          return earthquake;
        } else {
          throw Exception(response.statusMessage);
        }
      });
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<EarthquakeModel>> getOneWeekEarthquake() async {
    try {
      final response = await _dio.get(ApiEndpoints.inaTews.oneWeekEarthquakes);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final json = response.data['features'];

        return compute((json) {
          List<EarthquakeModel> earthquakes = [];

          for (var element in json) {
            earthquakes.add(EarthquakeModel.fromQLJson(element));
          }
          return earthquakes;
        }, json).then((List<EarthquakeModel> value) => value);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<EarthquakeModel>> getListEarthquakesFelt() async {
    final xmlToJson = Xml2Json();

    try {
      final response = await _dio.get(ApiEndpoints.inaTews.earthquakesFelt);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        xmlToJson.parse(response.data);

        return compute(jsonDecode, xmlToJson.toParker()).then((value) {
          return _parseEarthquakeData(value);
        });
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<EarthquakeModel>> getEarthquakesByType(
    EarthquakesType type,
  ) async {
    final xmlToJson = Xml2Json();

    try {
      final response = await _dio.get(earthquakeByTypeToUrl(type));

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        xmlToJson.parse(response.data);

        return compute(jsonDecode, xmlToJson.toParker()).then((value) {
          return _parseEarthquakeData(value);
        });
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<EarthquakeModel> _parseEarthquakeData(Map<String, dynamic> json) {
    try {
      List<EarthquakeModel> earthquakes = [];

      final containAlert = json.containsKey('alert');

      var containsStatus = (containAlert ? json['alert'] : json).containsKey(
        'status',
      );

      final isActual =
          containsStatus &&
          ((containAlert ? json['alert'] : json)['status'] as String)
                  .toLowerCase() ==
              'actual';

      if (isActual) {
        for (var element in json['alert']['info']) {
          earthquakes.add(EarthquakeModel.fromJson(element));
        }
      } else if (json.containsKey('Infogempa')) {
        for (var element in json['Infogempa']['gempa']) {
          earthquakes.add(EarthquakeModel.fromLiveJson(element));
        }
      } else {
        throw Exception('No data available');
      }

      return earthquakes;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String earthquakeByTypeToUrl(EarthquakesType type) {
    switch (type) {
      case EarthquakesType.felt:
        return ApiEndpoints.inaTews.earthquakesFelt;
      case EarthquakesType.realtime:
        return ApiEndpoints.inaTews.liveEarthquake;
      case EarthquakesType.overFive:
        return ApiEndpoints.inaTews.lastEarthquake;
      case EarthquakesType.tsunami:
        return ApiEndpoints.inaTews.earthquakesTsunami;
    }
  }
}
