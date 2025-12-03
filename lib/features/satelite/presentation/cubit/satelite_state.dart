part of 'satelite_cubit.dart';

abstract class SateliteState extends Equatable {
  const SateliteState();

  @override
  List<Object> get props => [];
}

class SateliteInitial extends SateliteState {}

class SateliteLoading extends SateliteState {}

class SateliteLoaded extends SateliteState {
  final List<SateliteEntity> images;

  const SateliteLoaded(this.images);

  @override
  List<Object> get props => [images];
}

class SateliteFailure extends SateliteState {
  final String message;

  const SateliteFailure(this.message);

  @override
  List<Object> get props => [message];
}
