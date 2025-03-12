import 'celestial_calculator_helper.dart';
import 'moon_calculator.dart';
import 'sun_calculator.dart';

class CelestialCalculator {
  final MoonCalculator moon = MoonCalculator();

  final SunCalculator sun = SunCalculator();

  final CelestialCalculatorHelper celestialHelper = CelestialCalculatorHelper();
}
