part of 'seismic_playback_cubit.dart';

class SeismicPlaybackState extends Equatable {
  final bool isLoading;
  final bool isPlaying;
  final List<EarthquakePgaEntity> pgaList;
  final double positionSeconds;
  final double durationSeconds;
  final String? message;

  const SeismicPlaybackState({
    this.isLoading = false,
    this.isPlaying = false,
    this.pgaList = const [],
    this.positionSeconds = 0.0,
    this.durationSeconds = 0.0,
    this.message,
  });

  SeismicPlaybackState copyWith({
    bool? isLoading,
    bool? isPlaying,
    List<EarthquakePgaEntity>? pgaList,
    double? positionSeconds,
    double? durationSeconds,
    String? message,
  }) {
    return SeismicPlaybackState(
      isLoading: isLoading ?? this.isLoading,
      isPlaying: isPlaying ?? this.isPlaying,
      pgaList: pgaList ?? this.pgaList,
      positionSeconds: positionSeconds ?? this.positionSeconds,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isPlaying,
    pgaList,
    positionSeconds,
    durationSeconds,
    message,
  ];
}
