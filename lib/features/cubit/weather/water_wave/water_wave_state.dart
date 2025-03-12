part of 'water_wave_cubit.dart';

@freezed
class WaterWaveState with _$WaterWaveState {
  const factory WaterWaveState.initial({
    @Default(BlocState.initial) BlocState status,
    List<WaterWaveEntity>? waves,
    String? message,
  }) = _Initial;
}
