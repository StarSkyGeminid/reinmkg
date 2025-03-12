part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @Default(BlocState.initial) BlocState status,
    LocationEntity? location,
    String? message,
  }) = _Initial;
}
