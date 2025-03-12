part of 'search_cloud_radar_bloc.dart';

@freezed
class SearchCloudRadarEvent with _$SearchCloudRadarEvent {
  const factory SearchCloudRadarEvent.started() = _Started;
  const factory SearchCloudRadarEvent.search(String query) = _Search;
}