import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reinmkg/core/api/api_endpoinds.dart';

import '../../../../seismic_playback/data/models/earthquake_pga_model.dart';

abstract class RemoteSeismicPlaybackService {
  Future<List<EarthquakePgaModel>> getEarthquakePgaData(String eventId);
}

class RemoteSeismicPlaybackServiceImpl implements RemoteSeismicPlaybackService {
  final Dio _dio = Dio();

  RemoteSeismicPlaybackServiceImpl();

  @override
  Future<List<EarthquakePgaModel>> getEarthquakePgaData(String eventId) {
    try {
      return _dio.get(ApiEndpoints.inaTews.earthquakePga(eventId)).then((
        response,
      ) {
        if (response.statusCode == HttpStatus.ok && response.data != null) {
          List<EarthquakePgaModel> pgaData = [];

          for (var pga in response.data['datapga']) {
            pgaData.add(EarthquakePgaModel.fromJson(pga));
          }

          return pgaData;
        } else {
          throw Exception(response.statusMessage);
        }
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
