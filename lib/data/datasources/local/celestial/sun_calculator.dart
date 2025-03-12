import '../../../../utils/helper/common.dart';
import 'celestial_calculator_helper.dart';

class SunCalculator {
  final CelestialCalculatorHelper _helper = CelestialCalculatorHelper();

  final List<List<dynamic>> times = [
    [-0.833, 'sunrise', 'sunset'],
    [-0.3, 'sunriseEnd', 'sunsetStart'],
    [-6, 'dawn', 'dusk'],
    [-12, 'nauticalDawn', 'nauticalDusk'],
    [-18, 'nightEnd', 'night'],
    [6, 'goldenHourEnd', 'goldenHour']
  ];

  Map<String, double> getPosition(DateTime date, double lat, double lng) {
    double lw = CelestialCalculatorHelper.rad * -lng;
    double phi = CelestialCalculatorHelper.rad * lat;
    double d = _helper.toDays(date);
    Map<String, double> c = _helper.sunCoords(d);
    double H = _helper.siderealTime(d, lw) - c['ra']!;

    return {
      'azimuth': _helper.azimuth(H, phi, c['dec']!),
      'altitude': _helper.altitude(H, phi, c['dec']!)
    };
  }

  double getSetJ(double h, double lw, double phi, double dec, double n,
      double M, double L) {
    try {
      double w = _helper.hourAngle(h, phi, dec);
      if (w.isNaN || w.isInfinite) {
        throw Exception('Invalid hour angle calculation');
      }

      double a = _helper.approxTransit(w, lw, n);
      if (a.isNaN || a.isInfinite) {
        throw Exception('Invalid transit approximation');
      }

      double jset = _helper.solarTransitJ(a, M, L);
      if (jset.isNaN || jset.isInfinite) {
        throw Exception('Invalid solar transit calculation');
      }

      return jset;
    } catch (e) {
      return double.nan;
    }
  }

  Map<String, DateTime?> getTimes(DateTime date, double lat, double lng) {
    try {
      double lw = CelestialCalculatorHelper.rad * -lng;
      double phi = CelestialCalculatorHelper.rad * lat;
      double d = _helper.toDays(date);

      if (lat > 90 || lat < -90) {
        throw ArgumentError(
            'Latitude harus berada di antara -90 dan 90 derajat');
      }
      if (lng > 180 || lng < -180) {
        throw ArgumentError(
            'Longitude harus berada di antara -180 dan 180 derajat');
      }

      Map<String, DateTime?> result = {};

      try {
        double n = _helper.julianCycle(d, lw);
        double ds = _helper.approxTransit(0, lw, n);

        if (ds.isNaN || ds.isInfinite) {
          throw Exception('Invalid solar transit calculation');
        }

        double M = _helper.solarMeanAnomaly(ds);
        double L = _helper.eclipticLongitude(M);
        double dec = _helper.declination(L, 0);
        double jnoon = _helper.solarTransitJ(ds, M, L);

        for (var time in times) {
          double h0 = time[0] * CelestialCalculatorHelper.rad;

          try {
            double jset = getSetJ(h0, lw, phi, dec, n, M, L);
            double jrise = jnoon - (jset - jnoon);

            if (!jset.isNaN &&
                !jrise.isNaN &&
                !jset.isInfinite &&
                !jrise.isInfinite) {
              result[time[1] as String] = _helper.fromJulian(jrise);
              result[time[2] as String] = _helper.fromJulian(jset);
            } else {
              result[time[1] as String] = null;
              result[time[2] as String] = null;
            }
          } catch (e) {
            result[time[1] as String] = null;
            result[time[2] as String] = null;
          }
        }
      } catch (e) {
        log.d('Error in getTimes: $e');
        for (var time in times) {
          result[time[1] as String] = null;
          result[time[2] as String] = null;
        }
      }

      log.d(result);
      return result;
    } catch (e) {
      log.d('Error in getTimes: $e');
      return Map.fromEntries(
        times.expand((time) => [
              MapEntry(time[1] as String, null),
              MapEntry(time[2] as String, null),
            ]),
      );
    }
  }
}
