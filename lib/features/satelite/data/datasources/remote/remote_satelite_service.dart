import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reinmkg/core/api/api_endpoinds.dart';

import '../../models/satelite_model.dart';

abstract class RemoteSateliteService {
  Future<List<SateliteModel>> getSateliteImages();
}

class RemoteSateliteServiceImpl implements RemoteSateliteService {
  final Dio _dio;

  RemoteSateliteServiceImpl(this._dio);

  @override
  Future<List<SateliteModel>> getSateliteImages() async {
    try {
      final response = await _dio.get(ApiEndpoints.bmkgApp.sateliteImage);

      if (response.statusCode == HttpStatus.ok && response.data != null) {
        final List<String> images = List<String>.from(response.data['data']);

        return images
            .map((path) => SateliteModel.fromPath(path))
            .toList()
            .reversed
            .toList();
      }

      throw Exception('Failed to load satelite images');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
