import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reinmkg/core/api/api_endpoinds.dart';

import '../../models/models.dart';

abstract class RemoteRadarService {
  Future<List<RadarModel>> getRadars();

  Future<List<RadarImageModel>> getRadarImages(String code);
}

class RemoteRadarServiceImpl implements RemoteRadarService {
  final Dio _dio;

  RemoteRadarServiceImpl(this._dio);

  @override
  Future<List<RadarModel>> getRadars() async {
    try {
      final response = await _dio.get(ApiEndpoints.sidarma.radarMeta);

      if (response.statusCode != HttpStatus.ok || response.data == null) {
        throw Exception(
          'Server returned ${response.statusCode}: ${response.statusMessage}',
        );
      }

      final weatherJson = response.data['datas'];

      return compute((json) {
        return json.map<RadarModel>((e) => RadarModel.fromJson(e)).toList();
      }, weatherJson).then((result) => result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RadarImageModel>> getRadarImages(String code) async {
    try {
      final response = await _dio.get(ApiEndpoints.sidarma.radar(code));

      if (response.statusCode != HttpStatus.ok || response.data == null) {
        throw Exception(
          'Server returned ${response.statusCode}: ${response.statusMessage}',
        );
      }

      final radarJson = response.data;

      return compute((radarJson) => parseRadarImages(radarJson), radarJson);
    } catch (e) {
      rethrow;
    }
  }
}
