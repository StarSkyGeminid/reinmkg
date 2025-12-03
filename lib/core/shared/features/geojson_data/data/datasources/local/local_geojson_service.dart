import 'dart:convert';

import 'package:flutter/services.dart';

abstract class LocalGeojsonDataService {
  Future<String> getRegionBorder();

  Future<String> getFaultLine();

  Future<String> getMaritimeBoundary();

  Future<String> getProvinceBorder();
}

class LocalRegionBorderOverlayServiceImpl implements LocalGeojsonDataService {
  @override
  Future<String> getRegionBorder() async {
    return rootBundle
        .load('lib/assets/json/district_border.geojson')
        .then(
          (value) {
            return utf8.decode(value.buffer.asUint8List());
          },
          onError: (e) {
            throw Exception('No Data');
          },
        );
  }

  @override
  Future<String> getFaultLine() async {
    return rootBundle
        .load('lib/assets/json/indo_faults_lines.json')
        .then(
          (value) => utf8.decode(value.buffer.asUint8List()),
          onError: (e) {
            throw Exception('No Data');
          },
        );
  }

  @override
  Future<String> getMaritimeBoundary() async {
    return rootBundle
        .load('lib/assets/json/wilayah_perairan.json')
        .then(
          (value) => utf8.decode(value.buffer.asUint8List()),
          onError: (e) {
            throw Exception('No Data');
          },
        );
  }

  @override
  Future<String> getProvinceBorder() async {
    return rootBundle
        .load('lib/assets/json/province_border.geojson')
        .then(
          (value) => utf8.decode(value.buffer.asUint8List()),
          onError: (e) {
            throw Exception('No Data');
          },
        );
  }
}
