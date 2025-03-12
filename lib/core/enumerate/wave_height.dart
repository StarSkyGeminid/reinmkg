enum WaveHeight {
  calm('Tenang'),
  low('Rendah'),
  medium('Sedang'),
  high('Tinggi'),
  veryHigh('Sangat Tinggi'),
  extreme('Ekstrim'),
  veryExtreme('Sangat Ekstrim'),
  ;

  final String nameId;

  const WaveHeight(this.nameId);

  factory WaveHeight.fromString(String value) {
    return WaveHeight.values.firstWhere((e) {
      return e.nameId.toLowerCase() == value.toLowerCase() ||
          e.toString() == value;
    });
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
