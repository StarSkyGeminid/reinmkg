part of 'selectable_earthquake_cubit.dart';

abstract class SelectableEarthquakeState extends Equatable {
  const SelectableEarthquakeState();

  @override
  List<Object?> get props => [];
}

class SelectableEarthquakeInitial extends SelectableEarthquakeState {}

class SelectableEarthquakeLoading extends SelectableEarthquakeState {}

class SelectableEarthquakeSelected extends SelectableEarthquakeState {
  final EarthquakeEntity earthquake;

  const SelectableEarthquakeSelected(this.earthquake);

  @override
  List<Object?> get props => [earthquake];
}

class SelectableEarthquakeFailure extends SelectableEarthquakeState {
  final String message;

  const SelectableEarthquakeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
