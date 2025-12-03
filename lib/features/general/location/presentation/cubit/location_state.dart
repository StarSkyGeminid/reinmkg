part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationEntity location;
  final bool isFromLast;

  const LocationLoaded(this.location, {this.isFromLast = false});

  @override
  List<Object> get props => [location, isFromLast];
}

class LocationFailure extends LocationState {
  final String error;

  const LocationFailure(this.error);

  @override
  List<Object> get props => [error];
}
