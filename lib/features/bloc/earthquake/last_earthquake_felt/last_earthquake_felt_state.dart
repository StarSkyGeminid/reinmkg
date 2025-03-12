part of 'last_earthquake_felt_bloc.dart';

@freezed
class LastEarthquakeFeltState with _$LastEarthquakeFeltState {
  const factory LastEarthquakeFeltState.initial({
    @Default(BlocState.initial) BlocState status,
    EarthquakeEntity? earthquake,
    String? message,
  }) = _Initial;
}
