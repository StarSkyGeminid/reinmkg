part of 'radar_selection_cubit.dart';

abstract class RadarSelectionState extends Equatable {
  const RadarSelectionState();

  @override
  List<Object?> get props => [];
}

class RadarSelectionInitial extends RadarSelectionState {}

class RadarSelectionLoading extends RadarSelectionState {}

class RadarSelectionLoaded extends RadarSelectionState {
  final RadarEntity radar;
  final List<RadarImageEntity> images;
  final RadarType type;

  const RadarSelectionLoaded({
    required this.radar,
    required this.images,
    required this.type,
  });

  @override
  List<Object?> get props => [radar, images, type];
}

class RadarSelectionFailure extends RadarSelectionState {
  final String message;

  const RadarSelectionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
