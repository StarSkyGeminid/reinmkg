part of 'weekly_weather_cubit.dart';

@freezed
class WeeklyWeatherState with _$WeeklyWeatherState {
  const factory WeeklyWeatherState({
    @Default(BlocState.initial) BlocState status,
    List<WeatherEntity>? weathers,
    String? message,
  }) = _Initial;
}
