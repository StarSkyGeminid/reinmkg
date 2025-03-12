part of 'recent_earthquake_bloc.dart';

@freezed
class RecentEarthquakeState with _$RecentEarthquakeState {
  const factory RecentEarthquakeState.initial({
    @Default(BlocState.initial) BlocState status,
    EarthquakeEntity? earthquake,
    String? message,
  }) = _Initial;
}
