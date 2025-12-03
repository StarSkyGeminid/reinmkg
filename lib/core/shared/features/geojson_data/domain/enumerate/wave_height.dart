enum WaveHeight {
  calm,
  low,
  medium,
  high,
  veryHigh,
  extreme,
  veryExtreme;

  const WaveHeight();

  /// Non-localized selector key for localization lookups.
  /// UI code should call `Strings.of(context).waveCategory(type.selectorKey)`
  /// to obtain a localized label.
  String get selectorKey {
    switch (this) {
      case WaveHeight.calm:
        return 'calm';
      case WaveHeight.low:
        return 'low';
      case WaveHeight.medium:
        return 'medium';
      case WaveHeight.high:
        return 'high';
      case WaveHeight.veryHigh:
        return 'veryHigh';
      case WaveHeight.extreme:
        return 'extreme';
      case WaveHeight.veryExtreme:
        return 'veryExtreme';
    }
  }
}

extension WaveHeightExtension on WaveHeight {
  double get getWaveHeightMin {
    switch (this) {
      case WaveHeight.calm:
        return 0.1;
      case WaveHeight.low:
        return 0.5;
      case WaveHeight.medium:
        return 1.25;
      case WaveHeight.high:
        return 2.50;
      case WaveHeight.veryHigh:
        return 4.0;
      case WaveHeight.extreme:
        return 6.0;
      case WaveHeight.veryExtreme:
        return 9.0;
    }
  }

  double get getWaveHeightMax {
    switch (this) {
      case WaveHeight.calm:
        return 0.4;
      case WaveHeight.low:
        return 1.24;
      case WaveHeight.medium:
        return 2.40;
      case WaveHeight.high:
        return 4.0;
      case WaveHeight.veryHigh:
        return 6.0;
      case WaveHeight.extreme:
        return 9.0;
      case WaveHeight.veryExtreme:
        return 14.0;
    }
  }
}
