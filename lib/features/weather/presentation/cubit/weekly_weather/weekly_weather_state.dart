part of 'weekly_weather_cubit.dart';

sealed class WeeklyWeatherState extends Equatable {
  const WeeklyWeatherState();

  @override
  List<Object> get props => [];
}

final class WeeklyWeatherInitial extends WeeklyWeatherState {}

final class WeeklyWeatherLoading extends WeeklyWeatherState {}

final class WeeklyWeatherLoaded extends WeeklyWeatherState {
  final List<WeatherEntity> weathers;

  const WeeklyWeatherLoaded(this.weathers);

  @override
  List<Object> get props => [weathers];
}

final class WeeklyWeatherFailure extends WeeklyWeatherState {
  final String message;

  const WeeklyWeatherFailure(this.message);

  @override
  List<Object> get props => [message];
}
