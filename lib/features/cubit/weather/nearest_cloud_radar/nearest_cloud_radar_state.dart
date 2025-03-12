part of 'nearest_cloud_radar_cubit.dart';

@freezed
class NearestCloudRadarState with _$NearestCloudRadarState {
  const factory NearestCloudRadarState.initial({
    @Default(BlocState.initial) BlocState status,
    RadarEntity? radar,
    String? message,
  }) = _Initial;
}
