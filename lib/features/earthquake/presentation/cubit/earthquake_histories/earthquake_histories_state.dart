part of 'earthquake_histories_cubit.dart';

abstract class EarthquakeHistoriesState extends Equatable {
  const EarthquakeHistoriesState();

  @override
  List<Object?> get props => [];
}

class EarthquakeHistoriesInitial extends EarthquakeHistoriesState {}

class EarthquakeHistoriesLoading extends EarthquakeHistoriesState {}

class EarthquakeHistoriesLoaded extends EarthquakeHistoriesState {
  final List<EarthquakeEntity> earthquakes;

  const EarthquakeHistoriesLoaded(this.earthquakes);

  @override
  List<Object?> get props => [earthquakes];
}

class EarthquakeHistoriesFailure extends EarthquakeHistoriesState {
  final String message;

  const EarthquakeHistoriesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
