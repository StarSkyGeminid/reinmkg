part of 'search_cloud_radar_bloc.dart';

@freezed
class SearchCloudRadarState with _$SearchCloudRadarState {
  const factory SearchCloudRadarState.initial({
    @Default(BlocState.initial) BlocState status,
    List<RadarEntity>? radars,
    String? message,
  }) = _Initial;
}
