enum MoonPhase {
  newMoon,
  waxingCrescent,
  firstQuarter,
  waxingGibbous,
  fullMoon,
  waningGibbous,
  lastQuarter,
  waningCrescent,
  ;

  factory MoonPhase.fromString(String value) {
    return MoonPhase.values.firstWhere((e) => e.name == value);
  }

  factory MoonPhase.fromPhaseAngle(double phase) {
    double angle = phase * 360;
    if (angle < 22.5) return MoonPhase.newMoon;
    if (angle < 67.5) return MoonPhase.waxingCrescent;
    if (angle < 112.5) return MoonPhase.firstQuarter;
    if (angle < 157.5) return MoonPhase.waningGibbous;
    if (angle < 202.5) return MoonPhase.fullMoon;
    if (angle < 247.5) return MoonPhase.waningGibbous;
    if (angle < 292.5) return MoonPhase.lastQuarter;
    if (angle < 337.5) return MoonPhase.waningCrescent;
    return MoonPhase.waningCrescent;
  }
}
