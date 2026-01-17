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
  late final Dio _dio;

  RemoteRadarServiceImpl() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "User-Agent": "okhttp/4.12.0",
          "x-api-key": "Oxl195umsKDiEL3IYO3p3rEd",
        },
      ),
    );
  }

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
