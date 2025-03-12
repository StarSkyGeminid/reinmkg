part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.initial({
    @Default(BlocState.initial) BlocState status,
    String? language,
    @Default(MeasurementUnit.metric) MeasurementUnit measurementUnit,
    String? message,
  }) = _Initial;
}
