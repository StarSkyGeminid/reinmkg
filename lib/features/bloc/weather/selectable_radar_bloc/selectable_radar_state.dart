part of 'selectable_radar_bloc.dart';

@freezed
class SelectableRadarState with _$SelectableRadarState {
  const factory SelectableRadarState.initial({
    @Default(BlocState.initial) BlocState status,
    RadarEntity? selectedRadar,
    List<RadarImageEntity>? radarImages,
    RadarImageEntity? selectedRadarImages,
    @Default(false) bool isPlaying,
    @Default(true) bool dirRight,
    @Default(RadarType.cmax) RadarType type,
    @Default(0) int currentIndex,
    String? message,
  }) = _Initial;
}
