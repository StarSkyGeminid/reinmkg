import 'package:flutter_test/flutter_test.dart';
import 'package:reinmkg/data/datasources/local/celestial/celestial.dart';
import 'package:mockito/mockito.dart';
import 'dart:math' as math;

// Mock classes for testing
class MockCelestialCalculatorHelper extends Mock
    implements CelestialCalculatorHelper {}

class MockSunCalculator extends Mock implements SunCalculator {}

class MockMoonCalculator extends Mock implements MoonCalculator {}

void main() {
  group('CelestialCalculatorHelper Detailed Tests', () {
    late CelestialCalculatorHelper helper;

    setUp(() {
      helper = CelestialCalculatorHelper();
    });

    group('Date Conversions', () {
      test('Julian Date Conversion - Present Date', () {
        final testDate = DateTime.utc(2024, 1, 1);
        final julianDate = helper.toJulian(testDate);
        final convertedDate = helper.fromJulian(julianDate);

        expect(convertedDate.year, equals(testDate.year));
        expect(convertedDate.month, equals(testDate.month));
        expect(convertedDate.day, equals(testDate.day));
      });

      test('Julian Date Conversion - Historical Date', () {
        final testDate = DateTime.utc(1970, 1, 1);
        final julianDate = helper.toJulian(testDate);
        expect(julianDate, closeTo(2440587.5, 0.1));
      });

      test('Julian Date Conversion - Future Date', () {
        final testDate = DateTime.utc(2050, 12, 31);
        final julianDate = helper.toJulian(testDate);
        final convertedDate = helper.fromJulian(julianDate);
        expect(convertedDate.year, equals(2050));
      });
    });

    group('Astronomical Calculations', () {
      test('Right Ascension Calculation', () {
        const l = CelestialCalculatorHelper.rad * 45; // 45 degrees
        const b = CelestialCalculatorHelper.rad * 30; // 30 degrees
        final ra = helper.rightAscension(l, b);
        expect(ra, isA<double>());
        expect(ra, inInclusiveRange(-math.pi, math.pi));
      });

      test('Declination Calculation', () {
        const l = CelestialCalculatorHelper.rad * 45;
        const b = CelestialCalculatorHelper.rad * 30;
        final dec = helper.declination(l, b);
        expect(dec, isA<double>());
        expect(dec, inInclusiveRange(-math.pi / 2, math.pi / 2));
      });

      test('Days Since J2000 Calculation', () {
        final dates = [
          DateTime.utc(2000, 1, 1),
          DateTime.utc(2024, 1, 1),
          DateTime.utc(1990, 1, 1),
        ];

        for (var date in dates) {
          final days = helper.toDays(date);
          expect(days, isA<double>());
        }
      });
    });
  });

  group('SunCalculator Extended Tests', () {
    late SunCalculator sunCalculator;
    late CelestialCalculatorHelper mockHelper;

    setUp(() {
      mockHelper = MockCelestialCalculatorHelper();
      sunCalculator = SunCalculator();
    });

    group('Position Calculations', () {
      test('Sun Position Calculation', () {
        final date = DateTime.utc(2024, 1, 1);
        const lat = 51.5074; // London
        const lng = -0.1278;

        final position = sunCalculator.getPosition(date, lat, lng);

        expect(position, isA<Map<String, double>>());
        expect(position.containsKey('azimuth'), isTrue);
        expect(position.containsKey('altitude'), isTrue);
        expect(position['azimuth'], inInclusiveRange(-math.pi, math.pi));
        expect(
            position['altitude'], inInclusiveRange(-math.pi / 2, math.pi / 2));
      });

      // test('Solar Mean Anomaly', () {
      //   final testDays = [0.0, 365.25, -365.25];
      //   for (var days in testDays) {
      //     final M = .solarMeanAnomaly(days);
      //     expect(M, isA<double>());
      //   }
      // });
    });

    group('SunCalculator Error Handling Tests', () {
      late SunCalculator sunCalculator;

      setUp(() {
        sunCalculator = SunCalculator();
      });

      test('getTimes handles extreme latitudes gracefully', () {
        final date = DateTime.utc(2024, 1, 1);
        final extremeLatitudes = [89.9, -89.9, 90.0, -90.0];

        for (var lat in extremeLatitudes) {
          final result = sunCalculator.getTimes(date, lat, 0);
          expect(result, isA<Map<String, dynamic>>());
          // Verifikasi bahwa hasil tetap valid atau null
          result.forEach((key, value) {
            expect(value == null || value is DateTime, isTrue);
          });
        }
      });

      test('getTimes handles invalid coordinates', () {
        final date = DateTime.utc(2024, 1, 1);

        // Test invalid latitude
        final result1 = sunCalculator.getTimes(date, 91, 0);
        expect(result1.values.every((v) => v == null), isTrue);

        // Test invalid longitude
        final result2 = sunCalculator.getTimes(date, 0, 181);
        expect(result2.values.every((v) => v == null), isTrue);
      });

      test('getTimes handles polar day/night scenarios', () {
        final summerSolstice = DateTime.utc(2024, 6, 21);
        final winterSolstice = DateTime.utc(2024, 12, 21);

        // Test near North Pole during summer
        final resultNorthSummer = sunCalculator.getTimes(summerSolstice, 89, 0);
        expect(resultNorthSummer, isA<Map<String, DateTime?>>());

        // Test near South Pole during winter
        final resultSouthWinter =
            sunCalculator.getTimes(winterSolstice, -89, 0);
        expect(resultSouthWinter, isA<Map<String, DateTime?>>());
      });

      test('getTimes returns consistent results for normal cases', () {
        final date = DateTime.utc(2024, 3, 20); // Spring equinox
        final normalLatitudes = [-45.0, -30.0, 0.0, 30.0, 45.0];

        for (var lat in normalLatitudes) {
          final result = sunCalculator.getTimes(date, lat, 0);
          expect(result['sunrise'], isA<DateTime?>());
          expect(result['sunset'], isA<DateTime?>());
        }
      });
    });
  });

  group('MoonCalculator Comprehensive Tests', () {
    late MoonCalculator moonCalculator;

    setUp(() {
      moonCalculator = MoonCalculator();
    });

    group('Position Calculations', () {
      test('Moon Position Calculation', () {
        final testCases = [
          {'date': DateTime.utc(2024, 1, 1), 'lat': 51.5074, 'lng': -0.1278},
          {'date': DateTime.utc(2024, 6, 21), 'lat': 40.7128, 'lng': -74.0060},
          {
            'date': DateTime.utc(2024, 12, 31),
            'lat': -33.8688,
            'lng': 151.2093
          },
        ];

        for (var testCase in testCases) {
          final position = moonCalculator.getPosition(
              testCase['date'] as DateTime,
              testCase['lat'] as double,
              testCase['lng'] as double);

          expect(position, isA<Map<String, double>>());
          expect(position.containsKey('azimuth'), isTrue);
          expect(position.containsKey('altitude'), isTrue);
          expect(position.containsKey('distance'), isTrue);
          expect(position.containsKey('parallacticAngle'), isTrue);
        }
      });

      test('Moon Coordinates Calculation', () {
        final days = [0.0, 29.53059, 365.25]; // Synodic month, year
        for (var d in days) {
          final coords = moonCalculator.moonCoords(d);
          expect(coords, isA<Map<String, double>>());
          expect(coords.containsKey('ra'), isTrue);
          expect(coords.containsKey('dec'), isTrue);
          expect(coords.containsKey('dist'), isTrue);
        }
      });
    });

    group('Time Calculations', () {
      test('Moon Times Calculation - Various Latitudes', () {
        final testCases = [
          {'lat': 0.0, 'lng': 0.0}, // Equator
          {'lat': 66.5, 'lng': 0.0}, // Arctic Circle
          {'lat': -66.5, 'lng': 0.0}, // Antarctic Circle
          {'lat': 45.0, 'lng': 0.0}, // Mid-latitude
        ];

        final date = DateTime.utc(2024, 3, 20); // Spring equinox

        for (var testCase in testCases) {
          final times = moonCalculator.getTimes(
              date, testCase['lat']!, testCase['lng']!, true);
          expect(times, isA<Map<String, dynamic>>());
        }
      });

      test('Hours Later Calculation', () {
        final date = DateTime.utc(2024, 1, 1);
        final hours = [1.0, 12.0, 24.0];

        for (var h in hours) {
          final later = moonCalculator.hoursLater(date, h);
          expect(later.difference(date).inHours, equals(h.toInt()));
        }
      });
    });
  });

  group('CelestialCalculator Integration Tests', () {
    late CelestialCalculator calculator;

    setUp(() {
      calculator = CelestialCalculator();
    });

    test('Full Day Cycle Calculation - Multiple Locations', () {
      final locations = [
        {'name': 'London', 'lat': 51.5074, 'lng': -0.1278},
        {'name': 'New York', 'lat': 40.7128, 'lng': -74.0060},
        {'name': 'Tokyo', 'lat': 35.6762, 'lng': 139.6503},
        {'name': 'Sydney', 'lat': -33.8688, 'lng': 151.2093},
      ];

      final testDates = [
        DateTime.utc(2024, 3, 20), // Spring equinox
        DateTime.utc(2024, 6, 21), // Summer solstice
        DateTime.utc(2024, 9, 23), // Fall equinox
        DateTime.utc(2024, 12, 21), // Winter solstice
      ];

      for (var location in locations) {
        for (var date in testDates) {
          // Test sun calculations
          final sunPosition = calculator.sun.getPosition(
              date, location['lat']! as double, location['lng']! as double);
          expect(sunPosition, isA<Map<String, double>>());

          // Test moon calculations
          final moonPosition = calculator.moon.getPosition(
              date, location['lat']! as double, location['lng']! as double);
          expect(moonPosition, isA<Map<String, double>>());
        }
      }
    });

    test('Edge Cases and Error Handling', () {
      // Test with extreme latitudes
      final extremeLatitudes = [90.0, -90.0, 89.9, -89.9];
      final date = DateTime.utc(2024, 1, 1);
      const lng = 0.0;

      for (var lat in extremeLatitudes) {
        expect(
            () => calculator.sun.getPosition(date, lat, lng), returnsNormally);
        expect(
            () => calculator.moon.getPosition(date, lat, lng), returnsNormally);
      }

      // Test with invalid dates
      expect(() => calculator.sun.getPosition(DateTime(1800, 1, 1), 0, 0),
          returnsNormally);
      expect(() => calculator.moon.getPosition(DateTime(2100, 1, 1), 0, 0),
          returnsNormally);
    });
  });
}
