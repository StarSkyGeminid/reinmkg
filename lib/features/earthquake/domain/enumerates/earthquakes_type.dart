enum EarthquakesType {
  felt,
  realtime,
  overFive,
  tsunami;

  bool get isFelt => this == EarthquakesType.felt;
  bool get isRealtime => this == EarthquakesType.realtime;
  bool get isOverFive => this == EarthquakesType.overFive;
  bool get isTsunami => this == EarthquakesType.tsunami;
}
