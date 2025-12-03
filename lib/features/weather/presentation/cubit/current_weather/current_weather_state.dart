part of 'current_weather_cubit.dart';

sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];
}

final class CurrentWeatherInitial extends CurrentWeatherState {}

final class CurrentWeatherLoading extends CurrentWeatherState {}

final class CurrentWeatherLoaded extends CurrentWeatherState {
  final WeatherEntity weather;

  const CurrentWeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

final class CurrentWeatherFailure extends CurrentWeatherState {
  final String message;

  const CurrentWeatherFailure(this.message);

  @override
  List<Object> get props => [message];
}
