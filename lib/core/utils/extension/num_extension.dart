extension TemperatureConversion on num {
  double get celciusToFahrenheit => (this * 9.0 / 5.0) + 32.0;

  double get fahrenheitToCelcius => (this - 32.0) * 5.0 / 9.0;
}

extension SpeedConversion on num {
  double get kmphToMilePerHour => this * 0.621371;

  double get mpsToKmph => this * 3.6;

  double get kmphToMps => this / 3.6;
}

extension DistanceConversion on num {
  double get metersToKilometers => this / 1000.0;

  double get kilometersToMiles => this * 0.621371;

  double get milimetersToInches => this * 0.0393701;
}

extension NumFormat on num {
  double toPrecision(int fractionDigits) =>
      double.parse(toStringAsFixed(fractionDigits));
}
