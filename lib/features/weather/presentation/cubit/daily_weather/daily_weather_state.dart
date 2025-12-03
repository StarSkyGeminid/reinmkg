part of 'daily_weather_cubit.dart';

sealed class DailyWeatherState extends Equatable {
  const DailyWeatherState();

  @override
  List<Object> get props => [];
}

final class DailyWeatherInitial extends DailyWeatherState {}

final class DailyWeatherLoading extends DailyWeatherState {}

final class DailyWeatherLoaded extends DailyWeatherState {
  final List<DailyWeatherEntity> weathers;

  const DailyWeatherLoaded(this.weathers);

  @override
  List<Object> get props => [weathers];
}

final class DailyWeatherFailure extends DailyWeatherState {
  final String message;

  const DailyWeatherFailure(this.message);

  @override
  List<Object> get props => [message];
}
