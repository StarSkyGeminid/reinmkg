import 'dart:math' as math;

import '../../../../utils/helper/common.dart';
import 'celestial_calculator_helper.dart';

class MoonCalculator {
  final CelestialCalculatorHelper _helper = CelestialCalculatorHelper();

  Map<String, double> moonCoords(double d) {
    double L = CelestialCalculatorHelper.rad * (218.316 + 13.176396 * d);
    double M = CelestialCalculatorHelper.rad * (134.963 + 13.064993 * d);
    double F = CelestialCalculatorHelper.rad * (93.272 + 13.229350 * d);
    double l1 = CelestialCalculatorHelper.rad * (357.529 + 0.985608 * d);
    double D = CelestialCalculatorHelper.rad * (297.850 + 12.190749 * d);

    double l = L +
        CelestialCalculatorHelper.rad *
            (6.288 * math.sin(M) +
                1.274 * math.sin(2 * D - M) +
                0.658 * math.sin(2 * D) +
                0.214 * math.sin(2 * M) -
                0.186 * math.sin(l1) -
                0.114 * math.sin(2 * F));

    double b = CelestialCalculatorHelper.rad *
        (5.128 * math.sin(F) +
            0.280 * math.sin(M + F) +
            0.277 * math.sin(M - F) +
            0.176 * math.sin(2 * D - F) +
            0.115 * math.sin(2 * D + F));

    double dt = 385001 -
        (20905 * math.cos(M) +
            3699 * math.cos(2 * D - M) +
            2956 * math.cos(2 * D) +
            570 * math.cos(2 * M) +
            246 * math.cos(2 * D - 2 * M));

    return {
      'ra': _helper.rightAscension(l, b),
      'dec': _helper.declination(l, b),
      'dist': dt
    };
  }

  Map<String, double> getPosition(DateTime date, double lat, double lng) {
    double lw = CelestialCalculatorHelper.rad * -lng;
    double phi = CelestialCalculatorHelper.rad * lat;
    double d = _helper.toDays(date);

    Map<String, double> c = moonCoords(d);
    double H = _helper.siderealTime(d, lw) - c['ra']!;
    double h = _helper.altitude(H, phi, c['dec']!);

    double pa = math.atan2(
        math.sin(H),
        math.tan(phi) * math.cos(c['dec']!) -
            math.sin(c['dec']!) * math.cos(H));

    return {
      'azimuth': _helper.azimuth(H, phi, c['dec']!),
      'altitude': h,
      'distance': c['dist']!,
      'parallacticAngle': pa
    };
  }

  Map<String, double> getIllumination(DateTime date) {
    DateTime utc = date.toUtc();

    double d = _helper.toDays(utc);
    double hours = utc.hour + utc.minute / 60 + utc.second / 3600;
    d += hours / 24;

    Map<String, double> s = _helper.sunCoords(d);
    Map<String, double> m = moonCoords(d);

    double sdist = s['dist']!;

    double phi = math.acos(math.sin(s['dec']!) * math.sin(m['dec']!) +
        math.cos(s['dec']!) *
            math.cos(m['dec']!) *
            math.cos(s['ra']! - m['ra']!));

    double inc =
        math.atan2(sdist * math.sin(phi), m['dist']! - sdist * math.cos(phi));

    double angle = math.atan2(
        math.cos(s['dec']!) * math.sin(s['ra']! - m['ra']!),
        math.sin(s['dec']!) * math.cos(m['dec']!) -
            math.cos(s['dec']!) *
                math.sin(m['dec']!) *
                math.cos(s['ra']! - m['ra']!));

    double fraction = ((1 + math.cos(inc)) / 2).clamp(0.0, 1.0);
    double phase = ((0.5 + 0.5 * inc * (angle < 0 ? -1 : 1) / math.pi) % 1.0);

    return {
      'fraction': fraction,
      'phase': phase,
      'angle': angle,
      'phaseAngle': inc * 180 / math.pi,
      'elongation': phi * 180 / math.pi
    };
  }

  // Map<String, double> getMoonIllumination(DateTime date) {
  //   double d = _helper.toDays(date);
  //   Map<String, double> s = _helper.sunCoords(d);
  //   Map<String, double> m = moonCoords(d);

  //   const double sdist = 149598000; // distance from Earth to Sun in km

  //   // Perhitungan sudut elongasi
  //   double phi = math.acos(math.sin(s['dec']!) * math.sin(m['dec']!) +
  //       math.cos(s['dec']!) *
  //           math.cos(m['dec']!) *
  //           math.cos(s['ra']! - m['ra']!));

  //   // Perhitungan sudut fase
  //   double inc =
  //       math.atan2(sdist * math.sin(phi), m['dist']! - sdist * math.cos(phi));

  //   // Perhitungan sudut posisi
  //   double angle = math.atan2(
  //       math.cos(s['dec']!) * math.sin(s['ra']! - m['ra']!),
  //       math.sin(s['dec']!) * math.cos(m['dec']!) -
  //           math.cos(s['dec']!) *
  //               math.sin(m['dec']!) *
  //               math.cos(s['ra']! - m['ra']!));

  //   // Perhitungan persentase iluminasi yang lebih akurat
  //   double fraction = (1 + math.cos(inc)) / 2;
  //   // Konversi ke persentase dan pembulatan ke 1 desimal
  //   double percentage = (fraction * 100).roundToDouble() / 10 * 10;

  //   return {
  //     'fraction': fraction,
  //     'phase': 0.5 + 0.5 * inc * (angle < 0 ? -1 : 1) / math.pi,
  //     'angle': angle,
  //     'percentage': percentage / 100
  //   };
  // }

  DateTime hoursLater(DateTime date, double h) {
    return DateTime.fromMillisecondsSinceEpoch(date.millisecondsSinceEpoch +
        (h * CelestialCalculatorHelper.dayMs ~/ 24));
  }

  Map<String, dynamic> getTimes(DateTime date, double lat, double lng,
      [bool inUTC = false]) {
    DateTime t;
    if (inUTC) {
      t = DateTime.utc(date.year, date.month, date.day);
    } else {
      t = DateTime(date.year, date.month, date.day);
    }

    double hc = 0.133 * CelestialCalculatorHelper.rad;
    double h0 = getPosition(t, lat, lng)['altitude']! - hc;
    double? rise, set;

    for (int i = 1; i <= 24; i += 2) {
      double h1 =
          getPosition(hoursLater(t, i.toDouble()), lat, lng)['altitude']! - hc;
      double h2 = getPosition(
              hoursLater(t, (i + 1).toDouble()), lat, lng)['altitude']! -
          hc;

      double a = (h0 + h2) / 2 - h1;
      double b = (h2 - h0) / 2;
      double xe = -b / (2 * a);
      double ye = (a * xe + b) * xe + h1;
      double d = b * b - 4 * a * h1;
      int roots = 0;

      if (d >= 0) {
        double dx = math.sqrt(d) / (a.abs() * 2);
        double x1 = xe - dx;
        double x2 = xe + dx;

        if (x1.abs() <= 1) roots++;
        if (x2.abs() <= 1) roots++;
        if (x1 < -1) x1 = x2;

        if (roots == 1) {
          if (h0 < 0) {
            rise = i + x1;
          } else {
            set = i + x1;
          }
        } else if (roots == 2) {
          rise = i + (ye < 0 ? x2 : x1);
          set = i + (ye < 0 ? x1 : x2);
        }
      }

      if (rise != null && set != null) break;

      h0 = h2;
    }

    Map<String, dynamic> result = {};

    Map<String, double> illumination = getIllumination(t);
    result['illumination'] = {
      'fraction': illumination['fraction'],
      'phase': illumination['phase'],
      'angle': illumination['angle'],
    };

    if (rise != null) {
      DateTime riseTime = hoursLater(t, rise);
      result['rise'] = {
        'time': riseTime,
        'azimuth': getPosition(riseTime, lat, lng)['azimuth']! * 180 / math.pi,
      };
    }

    if (set != null) {
      DateTime setTime = hoursLater(t, set);
      result['set'] = {
        'time': setTime,
        'azimuth': getPosition(setTime, lat, lng)['azimuth']! * 180 / math.pi,
      };
    }

    if (rise == null && set == null) {
      result[h0 > 0 ? 'alwaysUp' : 'alwaysDown'] = true;
    }

    log.d(result);

    return result;
  }

  double solarMeanAnomaly(double d) {
    return CelestialCalculatorHelper.rad * (357.5291 + 0.98560028 * d);
  }

  double eclipticLongitude(double M) {
    double C = CelestialCalculatorHelper.rad *
        (1.9148 * math.sin(M) +
            0.02 * math.sin(2 * M) +
            0.0003 * math.sin(3 * M));
    double P = CelestialCalculatorHelper.rad * 102.9372;
    return M + C + P + math.pi;
  }

  double approxTransit(double ht, double lw, double n) {
    return CelestialCalculatorHelper.j0 + (ht + lw) / (2 * math.pi) + n;
  }

  double solarTransitJ(double ds, double M, double L) {
    return CelestialCalculatorHelper.j2000 +
        ds +
        0.0053 * math.sin(M) -
        0.0069 * math.sin(2 * L);
  }

  double hourAngle(double h, double phi, double d) {
    return math.acos((math.sin(h) - math.sin(phi) * math.sin(d)) /
        (math.cos(phi) * math.cos(d)));
  }
}
