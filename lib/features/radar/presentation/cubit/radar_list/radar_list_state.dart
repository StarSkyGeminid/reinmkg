part of 'radar_list_cubit.dart';

abstract class RadarListState extends Equatable {
  const RadarListState();

  @override
  List<Object?> get props => [];
}

class RadarListInitial extends RadarListState {}

class RadarListLoading extends RadarListState {}

class RadarListLoaded extends RadarListState {
  final List<RadarEntity> radars;

  const RadarListLoaded({required this.radars});

  @override
  List<Object?> get props => [radars];
}

class RadarListFailure extends RadarListState {
  final String message;

  const RadarListFailure(this.message);

  @override
  List<Object?> get props => [message];
}
