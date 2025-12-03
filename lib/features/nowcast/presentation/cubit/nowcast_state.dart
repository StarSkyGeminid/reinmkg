part of 'nowcast_cubit.dart';

abstract class NowcastState extends Equatable {
  const NowcastState();

  @override
  List<Object> get props => [];
}

class NowcastInitial extends NowcastState {}

class NowcastLoading extends NowcastState {}

class NowcastLoaded extends NowcastState {
  final List<WeatherNowcastEntity> nowcasts;

  const NowcastLoaded(this.nowcasts);

  @override
  List<Object> get props => [nowcasts];
}

class NowcastFailure extends NowcastState {
  final String message;

  const NowcastFailure(this.message);

  @override
  List<Object> get props => [message];
}
