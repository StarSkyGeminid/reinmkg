import '../../models/celestial_model.dart';
import 'package:apsl_sun_calc/apsl_sun_calc.dart';

import '../../models/celestial_object_model.dart';

abstract class LocalCelestialService {
  Future<CelestialModel> getCelestialData(
    DateTime dateTime,
    double latitude,
    double longitude,
  );
}

class LocalCelestialServiceImpl implements LocalCelestialService {
  @override
  Future<CelestialModel> getCelestialData(
    DateTime dateTime,
    double latitude,
    double longitude,
  ) async {
    CelestialObjectModel sunModel = await _getSunData(
      dateTime,
      latitude,
      longitude,
    );

    CelestialObjectModel moonModel = _getMoonData(
      dateTime,
      latitude,
      longitude,
    );

    return CelestialModel(sun: sunModel, moon: moonModel);
  }

  Future<CelestialObjectModel> _getSunData(
    DateTime dateTime,
    double latitude,
    double longitude,
  ) async {
    Map<String, dynamic> sun = {};

    final sunPosition = SunCalc.getSunPosition(dateTime, latitude, longitude);

    sun.addAll(Map<String, dynamic>.from(sunPosition));

    final sunTimes = await SunCalc.getTimes(dateTime, latitude, longitude);

    sun.addAll(Map<String, dynamic>.from(sunTimes));

    return CelestialObjectModel.fromJson(sun);
  }

  CelestialObjectModel _getMoonData(
    DateTime dateTime,
    double latitude,
    double longitude,
  ) {
    Map<String, dynamic> moon = {};

    final moonPosition = SunCalc.getMoonPosition(dateTime, latitude, longitude);

    moon.addAll(Map<String, dynamic>.from(moonPosition));

    final moonTimes = SunCalc.getMoonTimes(dateTime, latitude, longitude);
    moon.addAll(moonTimes);

    final moonIllumination = SunCalc.getMoonIllumination(dateTime);

    moon.addAll(Map<String, dynamic>.from(moonIllumination));

    return CelestialObjectModel.fromJson(moon);
  }
}
