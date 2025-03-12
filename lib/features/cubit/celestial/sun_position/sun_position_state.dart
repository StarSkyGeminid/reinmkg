part of 'sun_position_cubit.dart';

@freezed
class SunPositionState with _$SunPositionState {
  const factory SunPositionState.initial({
    @Default(BlocState.initial) BlocState status,
    CelestialEntity? position,
    String? message,
  }) = _Initial;
}
