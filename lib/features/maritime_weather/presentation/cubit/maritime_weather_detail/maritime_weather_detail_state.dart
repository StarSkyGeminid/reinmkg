part of 'maritime_weather_detail_cubit.dart';

sealed class MaritimeWeatherDetailState extends Equatable {
  const MaritimeWeatherDetailState();

  @override
  List<Object> get props => [];
}

final class MaritimeWeatherDetailInitial extends MaritimeWeatherDetailState {}

final class MaritimeWeatherDetailLoading extends MaritimeWeatherDetailState {}

final class MaritimeWeatherDetailLoaded extends MaritimeWeatherDetailState {
  final List<MaritimeWeatherEntity> weatherDetails;

  const MaritimeWeatherDetailLoaded({required this.weatherDetails});

  @override
  List<Object> get props => [weatherDetails];
}

final class MaritimeWeatherDetailFailure extends MaritimeWeatherDetailState {
  final String message;

  const MaritimeWeatherDetailFailure({required this.message});

  @override
  List<Object> get props => [message];
}
