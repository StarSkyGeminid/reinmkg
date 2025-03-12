part of 'cloud_radars_cubit.dart';

@freezed
class CloudRadarsState with _$CloudRadarsState {
  const factory CloudRadarsState.initial({
    @Default(BlocState.initial) BlocState status,
    List<RadarEntity>? images,
    String? message,
  }) = _Initial;
}
