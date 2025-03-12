part of 'selectable_radar_bloc.dart';

@freezed
class SelectableRadarEvent with _$SelectableRadarEvent {
  const factory SelectableRadarEvent.started() = _Started;
  const factory SelectableRadarEvent.setRadar(RadarEntity entity) = _SetRadar;
  const factory SelectableRadarEvent.setRadarType(RadarType type) = _RadarType;
  const factory SelectableRadarEvent.play() = _Play;
  const factory SelectableRadarEvent.sliderChanged(int index) = _SliderChanged;
  const factory SelectableRadarEvent.previous() = _Previous;
  const factory SelectableRadarEvent.next() = _Next;
}
