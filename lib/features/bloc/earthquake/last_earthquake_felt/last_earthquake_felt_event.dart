part of 'last_earthquake_felt_bloc.dart';

@freezed
class LastEarthquakeFeltEvent with _$LastEarthquakeFeltEvent {
  const factory LastEarthquakeFeltEvent.started() = _Started;
}