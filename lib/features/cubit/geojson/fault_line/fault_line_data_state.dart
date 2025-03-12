part of 'fault_line_data_cubit.dart';

@freezed
class FaultLineDataState with _$FaultLineDataState {
  const factory FaultLineDataState.initial({
    @Default(BlocState.initial) BlocState status,
    String? faultLine,
    String? message,
  }) = _Initial;
}
