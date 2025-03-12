part of 'selectable_earthquake_bloc.dart';

@freezed
class SelectableEarthquakeEvent with _$SelectableEarthquakeEvent {
  const factory SelectableEarthquakeEvent.started() = _Started;
  const factory SelectableEarthquakeEvent.setEarthquake(
      EarthquakeEntity earthquakeEntity) = _SetEarthquake;
}
