part of 'selectable_earthquake_bloc.dart';

@freezed
class SelectableEarthquakeState with _$SelectableEarthquakeState {
  const factory SelectableEarthquakeState({
    @Default(BlocState.initial) BlocState status,
    EarthquakeEntity? earthquake,
    String? message,
  }) = _Initial;
}
