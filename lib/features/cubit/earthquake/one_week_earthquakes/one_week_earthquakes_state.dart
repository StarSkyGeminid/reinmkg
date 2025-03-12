part of 'one_week_earthquakes_cubit.dart';

@freezed
class OneWeekEarthquakesState with _$OneWeekEarthquakesState {
  const factory OneWeekEarthquakesState({
    @Default(BlocState.initial) BlocState status,
    List<EarthquakeEntity>? earthquakes,
    String? message,
  }) = _Initial;
}
