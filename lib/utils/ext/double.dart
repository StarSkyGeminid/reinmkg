extension DoubleExtension on double {
  double get celciusToFahrenheit => (this * 9 / 5) + 32;

  double get kmphToMilePerHour => this / 1.609344;

  double get kmToMiles => this / 1.609344;

  double get mmToInch => this * 0.03937008;

  double get meterToFeet => this * 3.28084;

  String shortenCoordinate() {
    return toStringAsFixed(3);
  }
}
