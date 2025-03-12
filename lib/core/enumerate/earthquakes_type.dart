enum EarthquakesType {
  felt('Dirasakan'),
  realtime('Terkini'),
  overFive('M > 5'),
  tsunami('Tsunami');

  final String name;

  const EarthquakesType(this.name);

  bool get isFelt => this == EarthquakesType.felt;
  bool get isRealtime => this == EarthquakesType.realtime;
  bool get isOverFive => this == EarthquakesType.overFive;
  bool get isTsunami => this == EarthquakesType.tsunami;
}
