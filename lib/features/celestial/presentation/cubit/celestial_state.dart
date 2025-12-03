part of 'celestial_cubit.dart';

abstract class CelestialState extends Equatable {
  const CelestialState();

  @override
  List<Object> get props => [];
}

class CelestialInitial extends CelestialState {}

class CelestialLoading extends CelestialState {}

class CelestialLoaded extends CelestialState {
  final CelestialEntity celestialData;

  const CelestialLoaded(this.celestialData);

  @override
  List<Object> get props => [celestialData];
}

class CelestialFailure extends CelestialState {
  final String message;

  const CelestialFailure(this.message);

  @override
  List<Object> get props => [message];
}
