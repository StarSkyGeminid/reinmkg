part of 'maritime_boundaries_cubit.dart';

@freezed
class MaritimeBoundariesState with _$MaritimeBoundariesState {
  const factory MaritimeBoundariesState.initial({
    @Default(BlocState.initial) BlocState status,
    String? boundaries,
    String? message,
  }) = _Initial;
}
