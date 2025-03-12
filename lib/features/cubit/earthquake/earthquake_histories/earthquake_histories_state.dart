part of 'earthquake_histories_cubit.dart';

@freezed
class EarthquakeHistoriesState with _$EarthquakeHistoriesState {
  const factory EarthquakeHistoriesState.initial({
    @Default(BlocState.initial) BlocState status,
    List<EarthquakeEntity>? earthquakes,
    String? message,
  }) = _Initial;
}
