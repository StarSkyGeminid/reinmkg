import 'dart:math' as math;

class SunCalc {
  static const double j0 = 0.0009;
  static const double rad = math.pi / 180;
  static const double dayMs = 1000 * 60 * 60 * 24;
  static const double j1970 = 2440587.5;
  static const double j2000 = 2451545.0;
  static const double e = rad * 23.4397;

  static double toJulian(DateTime date) {
    return date.millisecondsSinceEpoch / dayMs + j1970;
  }

  static DateTime fromJulian(double j) {
    return DateTime.fromMillisecondsSinceEpoch(((j - j1970) * dayMs).round());
  }

  static double toDays(DateTime date) {
    return toJulian(date) - j2000;
  }

  static double rightAscension(double l, double b) {
    return math.atan2(
        math.sin(l) * math.cos(e) - math.tan(b) * math.sin(e), math.cos(l));
  }

  static double declination(double l, double b) {
    return math.asin(
        math.sin(b) * math.cos(e) + math.cos(b) * math.sin(e) * math.sin(l));
  }

  static double azimuth(double H, double phi, double dec) {
    return math.atan2(math.sin(H),
        math.cos(H) * math.sin(phi) - math.tan(dec) * math.cos(phi));
  }

  static double altitude(double H, double phi, double dec) {
    return math.asin(math.sin(phi) * math.sin(dec) +
        math.cos(phi) * math.cos(dec) * math.cos(H));
  }

  static double siderealTime(double d, double lw) {
    double jc = d / 36525.0; 

    double gmst = 280.46061837 +
        360.98564736629 * d +
        0.000387933 * jc * jc -
        jc * jc * jc / 38710000.0;

    gmst = (gmst % 360.0 + 360.0) % 360.0;

    return (rad * gmst - lw) % (2 * math.pi);
  }

  static Map<String, double> getMoonPosition(
      DateTime date, double lat, double lng) {
    double lw = rad * -lng;
    double phi = rad * lat;
    double d = toDays(date);

    Map<String, double> c = moonCoords(d);
    double H = siderealTime(d, lw) - c['ra']!;
    double h = altitude(H, phi, c['dec']!);

    // Formula 14.1 of "Astronomical Algorithms" 2nd edition by Jean Meeus
    double pa = math.atan2(
        math.sin(H),
        math.tan(phi) * math.cos(c['dec']!) -
            math.sin(c['dec']!) * math.cos(H));

    return {
      'azimuth': azimuth(H, phi, c['dec']!),
      'altitude': h,
      'distance': c['dist']!,
      'parallacticAngle': pa
    };
  }

  static Map<String, double> sunCoords(double d) {
    double M = solarMeanAnomaly(d);
    double ecc =
        0.016708634 - 0.000042037 * d / 36525.0;
    double L0 = rad * (280.46646 + 36000.76983 * d / 36525.0);

    double C = rad *
        ((1.914602 - 0.004817 * d / 36525.0) * math.sin(M) +
            (0.019993 - 0.000101 * d / 36525.0) * math.sin(2 * M) +
            0.000289 * math.sin(3 * M));

    double L = L0 + C;

    double v = M + C;

    double R = (1.000001018 * (1 - ecc * ecc)) / (1 + ecc * math.cos(v));

    double O = rad * 0.0; 
    double lambda = L + O; 

    return {
      'dec': declination(lambda, 0),
      'ra': rightAscension(lambda, 0),
      'dist': R * 149597870.7 
    };
  }

  static Map<String, double> moonCoords(double d) {
    double L = rad * (218.316 + 13.176396 * d); // Moon's mean longitude
    double M = rad * (134.963 + 13.064993 * d); // Moon's mean anomaly
    double F = rad * (93.272 + 13.229350 * d); // Moon's argument of latitude
    double l1 = rad * (357.529 + 0.985608 * d); // Sun's mean anomaly
    double D = rad * (297.850 + 12.190749 * d); // Mean elongation from Sun

    double l = L +
        rad *
            (6.288750 * math.sin(M) +
                1.274018 * math.sin(2 * D - M) +
                0.658309 * math.sin(2 * D) +
                0.213616 * math.sin(2 * M) +
                -0.185596 * math.sin(l1) +
                -0.114336 * math.sin(2 * F) +
                0.058793 * math.sin(2 * D - 2 * M) +
                0.057212 * math.sin(2 * D - l1 - M) +
                0.053320 * math.sin(2 * D + M) +
                0.045874 * math.sin(2 * D - l1) +
                0.041024 * math.sin(M - l1));

    double b = rad *
        (5.128189 * math.sin(F) +
            0.280606 * math.sin(M + F) +
            0.277693 * math.sin(M - F) +
            0.176068 * math.sin(2 * D - F) +
            0.115175 * math.sin(2 * D + F) +
            0.059100 * math.sin(2 * M - F) +
            0.046180 * math.sin(2 * M + F) +
            -0.032364 * math.sin(M - 2 * F) +
            -0.015754 * math.sin(2 * l1 - F));

    double p = 385000.56 +
        (-20905.355 * math.cos(M) +
            -3699.111 * math.cos(2 * D - M) +
            -2956.457 * math.cos(2 * D) +
            -569.925 * math.cos(2 * M) +
            246.158 * math.cos(2 * D - 2 * M) +
            -204.586 * math.cos(l1) +
            -170.733 * math.cos(2 * D + M) +
            -152.138 * math.cos(2 * D - l1) +
            -129.620 * math.cos(D));

    return {'ra': rightAscension(l, b), 'dec': declination(l, b), 'dist': p};
  }

  static Map<String, double> getMoonIllumination(DateTime date) {
    double d = toDays(date);
    Map<String, double> s = sunCoords(d);
    Map<String, double> m = moonCoords(d);

    // Gunakan jarak matahari yang akurat dari sunCoords
    double sdist = s['dist']!;

    // Perhitungan elongasi yang lebih presisi
    double phi = math.acos(math.sin(s['dec']!) * math.sin(m['dec']!) +
        math.cos(s['dec']!) *
            math.cos(m['dec']!) *
            math.cos(s['ra']! - m['ra']!));

    // Perhitungan fase dengan koreksi parallax
    double inc =
        math.atan2(sdist * math.sin(phi), m['dist']! - sdist * math.cos(phi));

    double angle = math.atan2(
        math.cos(s['dec']!) * math.sin(s['ra']! - m['ra']!),
        math.sin(s['dec']!) * math.cos(m['dec']!) -
            math.cos(s['dec']!) *
                math.sin(m['dec']!) *
                math.cos(s['ra']! - m['ra']!));

    // Normalisasi dan koreksi fase
    double fraction = ((1 + math.cos(inc)) / 2).clamp(0.0, 1.0);
    double phase = ((0.5 + 0.5 * inc * (angle < 0 ? -1 : 1) / math.pi) % 1.0);

    return {
      'fraction': fraction,
      'phase': phase,
      'angle': angle,
      'phaseAngle': inc * 180 / math.pi, // Phase angle in degrees
      'elongation': phi * 180 / math.pi // Elongation in degrees
    };
  }

  static double solarMeanAnomaly(double d) {
    return rad * (357.5291 + 0.98560028 * d);
  }

  static double eclipticLongitude(double M) {
    // Perhitungan yang lebih detail untuk posisi matahari
    double C = rad *
        (1.9148 * math.sin(M) +
            0.02 * math.sin(2 * M) +
            0.0003 * math.sin(3 * M));
    double P = rad * 102.9372; // perihelion of the Earth
    return M + C + P + math.pi;
  }

  // static Map<String, double> getMoonIllumination(DateTime date) {
  //   double d = toDays(date);
  //   Map<String, double> s = sunCoords(d);
  //   Map<String, double> m = moonCoords(d);

  //   const double sdist = 149598000; // distance from Earth to Sun in km

  //   // Perhitungan elongasi (sudut Bumi-Bulan-Matahari)
  //   double phi = math.acos(math.sin(s['dec']!) * math.sin(m['dec']!) +
  //       math.cos(s['dec']!) *
  //           math.cos(m['dec']!) *
  //           math.cos(s['ra']! - m['ra']!));

  //   // Perhitungan fase dengan koreksi jarak
  //   double inc =
  //       math.atan2(sdist * math.sin(phi), m['dist']! - sdist * math.cos(phi));

  //   // Perhitungan sudut fase
  //   double angle = math.atan2(
  //       math.cos(s['dec']!) * math.sin(s['ra']! - m['ra']!),
  //       math.sin(s['dec']!) * math.cos(m['dec']!) -
  //           math.cos(s['dec']!) *
  //               math.sin(m['dec']!) *
  //               math.cos(s['ra']! - m['ra']!));

  //   // Normalisasi hasil
  //   double fraction = (1 + math.cos(inc)) / 2;
  //   double phase = 0.5 + 0.5 * inc * (angle < 0 ? -1 : 1) / math.pi;

  //   // Debug output
  //   print('Debug illumination:');
  //   print('Days since J2000: $d');
  //   print('Sun coords - RA: ${s['ra']}, Dec: ${s['dec']}');
  //   print('Moon coords - RA: ${m['ra']}, Dec: ${m['dec']}, Dist: ${m['dist']}');
  //   print('Phi: $phi');
  //   print('Inc: $inc');
  //   print('Angle: $angle');
  //   print('Raw fraction: $fraction');

  //   return {'fraction': fraction, 'phase': phase, 'angle': angle};
  // }

  // static Map<String, double> getMoonIllumination(DateTime date) {
  //   double d = toDays(date);
  //   Map<String, double> s = sunCoords(d);
  //   Map<String, double> m = moonCoords(d);

  //   const double sdist = 149598000; // distance from Earth to Sun in km

  //   double phi = math.acos(math.sin(s['dec']!) * math.sin(m['dec']!) +
  //       math.cos(s['dec']!) *
  //           math.cos(m['dec']!) *
  //           math.cos(s['ra']! - m['ra']!));
  //   double inc =
  //       math.atan2(sdist * math.sin(phi), m['dist']! - sdist * math.cos(phi));
  //   double angle = math.atan2(
  //       math.cos(s['dec']!) * math.sin(s['ra']! - m['ra']!),
  //       math.sin(s['dec']!) * math.cos(m['dec']!) -
  //           math.cos(s['dec']!) *
  //               math.sin(m['dec']!) *
  //               math.cos(s['ra']! - m['ra']!));

  //   return {
  //     'fraction': (1 + math.cos(inc)) / 2,
  //     'phase': 0.5 + 0.5 * inc * (angle < 0 ? -1 : 1) / math.pi,
  //     'angle': angle
  //   };
  // }

  static DateTime hoursLater(DateTime date, double h) {
    return DateTime.fromMillisecondsSinceEpoch(
        date.millisecondsSinceEpoch + (h * dayMs ~/ 24));
  }

  static Map<String, dynamic> getMoonTimes(
      DateTime date, double lat, double lng,
      [bool inUTC = false]) {
    DateTime t;
    if (inUTC) {
      t = DateTime.utc(date.year, date.month, date.day);
    } else {
      t = DateTime(date.year, date.month, date.day);
    }

    double hc = 0.133 * rad;
    double h0 = getMoonPosition(t, lat, lng)['altitude']! - hc;
    double? rise, set;

    // Go through each hour of the day
    for (int i = 1; i <= 24; i += 2) {
      double h1 =
          getMoonPosition(hoursLater(t, i.toDouble()), lat, lng)['altitude']! -
              hc;
      double h2 = getMoonPosition(
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

    // Menambahkan informasi fase bulan
    Map<String, double> illumination = getMoonIllumination(t);
    result['illumination'] = {
      'fraction': illumination['fraction'],
      'phase': illumination['phase'],
      'angle': illumination['angle'],
    };

    if (rise != null) {
      DateTime riseTime = hoursLater(t, rise);
      result['rise'] = {
        'time': riseTime,
        'azimuth':
            getMoonPosition(riseTime, lat, lng)['azimuth']! * 180 / math.pi,
      };
    }

    if (set != null) {
      DateTime setTime = hoursLater(t, set);
      result['set'] = {
        'time': setTime,
        'azimuth':
            getMoonPosition(setTime, lat, lng)['azimuth']! * 180 / math.pi,
      };
    }

    if (rise == null && set == null) {
      result[h0 > 0 ? 'alwaysUp' : 'alwaysDown'] = true;
    }

    return result;
  }

  // // Sun calculations
  // static Map<String, double> sunCoords(double d) {
  //   double M = solarMeanAnomaly(d);
  //   double L = eclipticLongitude(M);

  //   return {'dec': declination(L, 0), 'ra': rightAscension(L, 0)};
  // }

  // static double solarMeanAnomaly(double d) {
  //   return rad * (357.5291 + 0.98560028 * d);
  // }

  // static double eclipticLongitude(double M) {
  //   double C = rad *
  //       (1.9148 * math.sin(M) +
  //           0.02 * math.sin(2 * M) +
  //           0.0003 * math.sin(3 * M));
  //   double P = rad * 102.9372;
  //   return M + C + P + math.pi;
  // }

  static final List<List<dynamic>> times = [
    [-0.833, 'sunrise', 'sunset'],
    [-0.3, 'sunriseEnd', 'sunsetStart'],
    [-6, 'dawn', 'dusk'],
    [-12, 'nauticalDawn', 'nauticalDusk'],
    [-18, 'nightEnd', 'night'],
    [6, 'goldenHourEnd', 'goldenHour']
  ];

  // Sun position calculations
  static Map<String, double> getPosition(
      DateTime date, double lat, double lng) {
    double lw = rad * -lng;
    double phi = rad * lat;
    double d = toDays(date);
    Map<String, double> c = sunCoords(d);
    double H = siderealTime(d, lw) - c['ra']!;

    return {
      'azimuth': azimuth(H, phi, c['dec']!),
      'altitude': altitude(H, phi, c['dec']!)
    };
  }

  // Calculations for sun times
  static double julianCycle(double d, double lw) {
    return (d - j0 - lw / (2 * math.pi)).round().toDouble();
  }

  static double approxTransit(double ht, double lw, double n) {
    return j0 + (ht + lw) / (2 * math.pi) + n;
  }

  static double solarTransitJ(double ds, double M, double L) {
    return j2000 + ds + 0.0053 * math.sin(M) - 0.0069 * math.sin(2 * L);
  }

  static double hourAngle(double h, double phi, double d) {
    return math.acos((math.sin(h) - math.sin(phi) * math.sin(d)) /
        (math.cos(phi) * math.cos(d)));
  }

  // Returns set time for the given sun altitude
  static double getSetJ(double h, double lw, double phi, double dec, double n,
      double M, double L) {
    double w = hourAngle(h, phi, dec);
    double a = approxTransit(w, lw, n);
    return solarTransitJ(a, M, L);
  }

  // Calculates sun times for a given date and location
  static Map<String, DateTime> getTimes(DateTime date, double lat, double lng) {
    double lw = rad * -lng;
    double phi = rad * lat;
    double d = toDays(date);
    double n = julianCycle(d, lw);
    double ds = approxTransit(0, lw, n);
    double M = solarMeanAnomaly(ds);
    double L = eclipticLongitude(M);
    double dec = declination(L, 0);
    double jnoon = solarTransitJ(ds, M, L);

    Map<String, DateTime> result = {
      'solarNoon': fromJulian(jnoon),
      'nadir': fromJulian(jnoon - 0.5)
    };

    for (var time in times) {
      double h0 = (time[0]) * rad;
      double jset = getSetJ(h0, lw, phi, dec, n, M, L);
      double jrise = jnoon - (jset - jnoon);

      result[time[1]] = fromJulian(jrise); // Morning time
      result[time[2]] = fromJulian(jset); // Evening time
    }

    return result;
  }
}

// Example usage:
void main() {
  DateTime now = DateTime.now();
  double lat = -7.8032484;
  double lng = 110.3335593;

  // double lat = -6.2088; // Jakarta latitude
  // double lng = 106.8456; // Jakarta longitude

  // double lat = -2.5651354; // Jayapura latitude
  // double lng = 140.5984541; // Jayapura longitude

  // Get sun times
  Map<String, DateTime> sunTimes = SunCalc.getTimes(now, lat, lng);
  Map<String, double> sunPos = SunCalc.getPosition(now, lat, lng);

  // Print all sun times
  print('Sun Times for ${now.toString().split(' ')[0]}:');
  sunTimes.forEach((key, value) {
    print('$key: $value');
  });

  // // Get moon data
  // Map<String, dynamic> moonPos = SunCalc.getMoonPosition(now, lat, lng);
  // Map<String, dynamic> moonTimes = SunCalc.getMoonTimes(now, lat, lng);
  Map<String, double> moonIllum = SunCalc.getMoonIllumination(now);

  // SunCalc.getMoonIllumination(now.subtract(const Duration(days: 1)));

  // SunCalc.getMoonIllumination(now.add(const Duration(days: 1)));

  // print('\nMoon Times:');
  // if (moonTimes.containsKey('rise')) {
  //   print('Moonrise: ${moonTimes['rise']}');
  // }
  // if (moonTimes.containsKey('set')) {
  //   print('Moonset: ${moonTimes['set']}');
  // }

  // print('\nMoon Phase:');
  print('Illumination: ${(SunCalc.getMoonIllumination(now.subtract(const Duration(days: 1)))['fraction']! * 100).toStringAsFixed(1)}%');
  print('Illumination: ${(SunCalc.getMoonIllumination(now)['fraction']! * 100).toStringAsFixed(1)}%');
  print('Illumination: ${(SunCalc.getMoonIllumination(now.add(const Duration(days: 1)))['fraction']! * 100).toStringAsFixed(1)}%');
  // print('Phase: ${(moonIllum['phase']! * 360).toStringAsFixed(1)}°');

  // print(sunTimes);
  // print(sunPos);
  // print('\n');
  // print(moonPos);
  // print(moonTimes);
  // print(moonIllum);
}
