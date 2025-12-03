enum RadarUnit {
  dbz,
  mm,
  mmhr;

  bool get isDbz => this == RadarUnit.dbz;
  bool get isMm => this == RadarUnit.mm;
  bool get isMmhr => this == RadarUnit.mmhr;

  String displayName({bool isMetric = true}) {
    switch (this) {
      case RadarUnit.dbz:
        return 'dBZ';
      case RadarUnit.mm:
        return isMetric ? 'mm' : 'in';
      case RadarUnit.mmhr:
        return isMetric ? 'mm/hr' : 'in/hr';
    }
  }
}
