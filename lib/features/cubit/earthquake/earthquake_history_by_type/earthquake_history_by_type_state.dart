part of 'earthquake_history_by_type_cubit.dart';

@freezed
class EarthquakeHistoryByTypeState with _$EarthquakeHistoryByTypeState {
  const factory EarthquakeHistoryByTypeState.initial({
    @Default(BlocState.initial) BlocState status,
    List<EarthquakeEntity>? earthquakes,
    String? message,
  }) = _Initial;
}
