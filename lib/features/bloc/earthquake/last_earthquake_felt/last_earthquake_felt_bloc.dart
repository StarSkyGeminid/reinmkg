import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../../domain/usecases/earthquake/stream_last_earthquake_usecase.dart';

part 'last_earthquake_felt_event.dart';
part 'last_earthquake_felt_state.dart';
part 'last_earthquake_felt_bloc.freezed.dart';

class LastEarthquakeFeltBloc
    extends Bloc<LastEarthquakeFeltEvent, LastEarthquakeFeltState> {
  final StreamLastEarthquakeFelt _earthquakeFelt;

  LastEarthquakeFeltBloc(this._earthquakeFelt) : super(const _Initial()) {
    on<LastEarthquakeFeltEvent>((events, emit) async {
      await events.map(
        started: (_) => _onGetLastEarthquakeFelt(emit),
      );
    });
  }

  bool _isStarted = true;

  Future<void> _onGetLastEarthquakeFelt(
      Emitter<LastEarthquakeFeltState> emit) async {
    emit(state.copyWith(status: BlocState.loading));

    return _listenStream(emit);
  }

  Future<void> _listenStream(Emitter<LastEarthquakeFeltState> emit) {
    final streamData = _earthquakeFelt.call();

    final player = AudioPlayer();

    return emit.forEach(streamData, onData: (earthquake) {
      if (!_isStarted) {
        if ((earthquake.magnitude ?? 3) > 4) {
          player.play(AssetSource('audio/General Earthquake.mp3'));
        } else if (earthquake.tsunamiData != null) {
          player.play(AssetSource('audio/Tsunami.mp3'));
        }
      }

      _isStarted = false;

      return state.copyWith(
        status: BlocState.success,
        earthquake: earthquake,
      );
    }, onError: (e, s) {
      return state.copyWith(
        status: BlocState.failure,
        message: 'Tidak dapat mendapatkan gempa bumi dirasakan terkini',
      );
    });
  }
}
