import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:reinmkg/utils/helper/common.dart';

import '../../../../core/error/failure.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract class LocalGeojsonService {
  Future<Either<Failure, String>> getFaultLine();

  Future<Either<Failure, String>> getMaritimeBoundaries();

  Future<Either<Failure, String>> getProviceBorder();
}

class LocalGeojsonServiceImpl implements LocalGeojsonService {
  @override
  Future<Either<Failure, String>> getFaultLine() async {
    return rootBundle.load('assets/json/indo_faults_lines.json').then((value) {
      return Right(utf8.decode(value.buffer.asUint8List()));
    }, onError: (e) {
      log.e(e.toString());

      return Left(NoDataFailure());
    });
  }

  @override
  Future<Either<Failure, String>> getMaritimeBoundaries() {
    return rootBundle.load('assets/json/wilayah_perairan.json').then((value) {
      return Right(utf8.decode(value.buffer.asUint8List()));
    }, onError: (e) {
      log.e(e.toString());

      return Left(NoDataFailure());
    });
  }

  @override
  Future<Either<Failure, String>> getProviceBorder() {
    return rootBundle.load('assets/json/kab_kota.geojson').then((value) {
      return Right(utf8.decode(value.buffer.asUint8List()));
    }, onError: (e) {
      log.e(e.toString());

      return Left(NoDataFailure());
    });
  }
}
