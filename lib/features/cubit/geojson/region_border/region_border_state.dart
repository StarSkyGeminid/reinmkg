part of 'region_border_cubit.dart';

@freezed
class ProvinceBorderState with _$ProvinceBorderState {
  const factory ProvinceBorderState.initial({
    @Default(BlocState.initial) BlocState status,
    String? provinceBorder,
    String? message,
  }) = _Initial;
}
