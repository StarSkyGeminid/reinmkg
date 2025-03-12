import 'dart:math' as math;

class CelestialCalculatorHelper {
  static const double j0 = 0.0009;
  static const double rad = math.pi / 180;
  static const double dayMs = 1000 * 60 * 60 * 24;
  static const double j1970 = 2440587.5;
  static const double j2000 = 2451545.0;
  static const double e = rad * 23.4397;

  double toJulian(DateTime date) {
    return date.millisecondsSinceEpoch / dayMs + j1970;
  }

  DateTime fromJulian(double j) {
    return DateTime.fromMillisecondsSinceEpoch(((j - j1970) * dayMs).round());
  }

  double toDays(DateTime date) {
    return toJulian(date) - j2000;
  }

  double rightAscension(double l, double b) {
    return math.atan2(
        math.sin(l) * math.cos(e) - math.tan(b) * math.sin(e), math.cos(l));
  }

  double declination(double l, double b) {
    return math.asin(
        math.sin(b) * math.cos(e) + math.cos(b) * math.sin(e) * math.sin(l));
  }

  double azimuth(double H, double phi, double dec) {
    return math.atan2(math.sin(H),
        math.cos(H) * math.sin(phi) - math.tan(dec) * math.cos(phi));
  }

  double altitude(double H, double phi, double dec) {
    return math.asin(math.sin(phi) * math.sin(dec) +
        math.cos(phi) * math.cos(dec) * math.cos(H));
  }

  double siderealTime(double d, double lw) {
    double jc = d / 36525.0;

    double gmst = 280.46061837 +
        360.98564736629 * d +
        0.000387933 * jc * jc -
        jc * jc * jc / 38710000.0;

    gmst = (gmst % 360.0 + 360.0) % 360.0;

    return (rad * gmst - lw) % (2 * math.pi);
  }

  DateTime hoursLater(DateTime date, double h) {
    return DateTime.fromMillisecondsSinceEpoch(
        date.millisecondsSinceEpoch + (h * dayMs ~/ 24));
  }

  double solarMeanAnomaly(double d) {
    return rad * (357.5291 + 0.98560028 * d);
  }

  double eclipticLongitude(double M) {
    double C = rad *
        (1.9148 * math.sin(M) +
            0.02 * math.sin(2 * M) +
            0.0003 * math.sin(3 * M));
    double P = rad * 102.9372;
    return M + C + P + math.pi;
  }

  double julianCycle(double d, double lw) {
    return (d - j0 - lw / (2 * math.pi)).round().toDouble();
  }

  double approxTransit(double ht, double lw, double n) {
    return j0 + (ht + lw) / (2 * math.pi) + n;
  }

  double solarTransitJ(double ds, double M, double L) {
    return j2000 + ds + 0.0053 * math.sin(M) - 0.0069 * math.sin(2 * L);
  }

  double hourAngle(double h, double phi, double d) {
    try {
      double term1 = math.sin(h) - math.sin(phi) * math.sin(d);
      double term2 = math.cos(phi) * math.cos(d);

      if (term2.abs() < 1e-10) {
        throw Exception('Division by zero in hour angle calculation');
      }

      double value = term1 / term2;

      if (value < -1) return math.pi;
      if (value > 1) return 0;

      return math.acos(value);
    } catch (e) {
      return double.nan;
    }
  }

  Map<String, double> sunCoords(double d) {
    double M = solarMeanAnomaly(d);
    double ecc =
        0.016708634 - 0.000042037 * d / 36525.0; 
    double l0 = rad * (280.46646 + 36000.76983 * d / 36525.0); 

    double C = rad *
        ((1.914602 - 0.004817 * d / 36525.0) * math.sin(M) +
            (0.019993 - 0.000101 * d / 36525.0) * math.sin(2 * M) +
            0.000289 * math.sin(3 * M));

    double L = l0 + C;

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
}
