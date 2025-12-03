import 'package:dio/dio.dart';
import 'package:reinmkg/core/api/api_endpoinds.dart';

import '../../models/location_model.dart';

abstract class RemoteLocationService {
  Future<LocationModel> getNearestLocation(double latitude, double longitude);
}

class RemoteLocationServiceImpl implements RemoteLocationService {
  final Dio _dio;

  RemoteLocationServiceImpl(this._dio);

  @override
  Future<LocationModel> getNearestLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.bmkgApp.nearestLocation,
        queryParameters: {
          'lon': double.parse(longitude.toStringAsPrecision(5)),
          'lat': double.parse(latitude.toStringAsPrecision(5)),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return LocationModel.fromJson(response.data);
      }

      throw Exception(
        'Server returned ${response.statusCode}: ${response.statusMessage}',
      );
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error');
    }
  }
}
