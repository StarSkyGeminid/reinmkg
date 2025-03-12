part of 'current_weather_cubit.dart';

@freezed
class CurrentWeatherState with _$CurrentWeatherState {
  const factory CurrentWeatherState({
    @Default(BlocState.initial) BlocState status,
    WeatherEntity? weather,
    String? message,
  }) = _Initial;
}
