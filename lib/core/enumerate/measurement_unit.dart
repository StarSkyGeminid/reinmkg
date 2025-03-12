enum MeasurementUnit {
  metric,
  imperial,
  ;

  bool get isMetric => this == MeasurementUnit.metric;
  bool get isImperial => this == MeasurementUnit.imperial;
}
