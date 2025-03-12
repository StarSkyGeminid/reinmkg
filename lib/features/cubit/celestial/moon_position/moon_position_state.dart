part of 'moon_position_cubit.dart';

@freezed
class MoonPositionState with _$MoonPositionState {
  const factory MoonPositionState.initial({
    @Default(BlocState.initial) BlocState status,
    CelestialEntity? position,
    String? message,
  }) = _Initial;
}
