part of 'earthquake_cubit.dart';

abstract class EarthquakeState extends Equatable {
  const EarthquakeState();

  @override
  List<Object?> get props => [];
}

class EarthquakeInitial extends EarthquakeState {
  const EarthquakeInitial();
}

class EarthquakeLoading extends EarthquakeState {
  const EarthquakeLoading();
}

class EarthquakeLoaded extends EarthquakeState {
  final EarthquakeEntity earthquake;
  const EarthquakeLoaded(this.earthquake);

  @override
  List<Object?> get props => [earthquake];
}

class EarthquakeFailure extends EarthquakeState {
  final String message;
  const EarthquakeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
