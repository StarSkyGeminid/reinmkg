part of 'playback_cubit.dart';

class PlaybackState extends Equatable {
  final int index;
  final bool playing;

  const PlaybackState({required this.index, required this.playing});

  @override
  List<Object?> get props => [index, playing];
}
