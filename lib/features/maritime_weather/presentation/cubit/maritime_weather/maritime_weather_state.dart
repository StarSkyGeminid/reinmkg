part of 'maritime_weather_cubit.dart';

abstract class MaritimeWeatherState extends Equatable {
  const MaritimeWeatherState();

  @override
  List<Object> get props => [];
}

class MaritimeWeatherInitial extends MaritimeWeatherState {}

class MaritimeWeatherLoading extends MaritimeWeatherState {}

class MaritimeWeatherLoaded extends MaritimeWeatherState {
  final List<WaterWaveEntity> waves;

  const MaritimeWeatherLoaded({required this.waves});

  @override
  List<Object> get props => [waves];
}

class MaritimeWeatherFailure extends MaritimeWeatherState {
  final String message;

  const MaritimeWeatherFailure({required this.message});

  @override
  List<Object> get props => [message];
}
