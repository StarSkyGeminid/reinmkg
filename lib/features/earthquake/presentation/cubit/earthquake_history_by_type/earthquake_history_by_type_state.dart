part of 'earthquake_history_by_type_cubit.dart';

abstract class EarthquakeHistoryByTypeState extends Equatable {
  const EarthquakeHistoryByTypeState();

  @override
  List<Object?> get props => [];
}

class EarthquakeHistoryByTypeInitial extends EarthquakeHistoryByTypeState {}

class EarthquakeHistoryByTypeLoading extends EarthquakeHistoryByTypeState {}

class EarthquakeHistoryByTypeLoaded extends EarthquakeHistoryByTypeState {
  final List<EarthquakeEntity> earthquakes;

  const EarthquakeHistoryByTypeLoaded(this.earthquakes);

  @override
  List<Object?> get props => [earthquakes];
}

class EarthquakeHistoryByTypeFailure extends EarthquakeHistoryByTypeState {
  final String message;
  const EarthquakeHistoryByTypeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
