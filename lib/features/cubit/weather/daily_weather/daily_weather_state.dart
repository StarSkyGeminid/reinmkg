part of 'daily_weather_cubit.dart';

@freezed
class DailyWeatherState with _$DailyWeatherState {
  const factory DailyWeatherState({
    @Default(BlocState.initial) BlocState status,
    List<DailyWeatherEntity>? weathers,
    String? message,
  }) = _Initial;
}
