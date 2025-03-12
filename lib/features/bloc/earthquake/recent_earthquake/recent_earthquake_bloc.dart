import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reinmkg/domain/domain.dart';

import '../../../../core/enumerate/bloc_state.dart';

part 'recent_earthquake_event.dart';
part 'recent_earthquake_state.dart';
part 'recent_earthquake_bloc.freezed.dart';

class RecentEarthquakeBloc
    extends Bloc<RecentEarthquakeEvent, RecentEarthquakeState> {
  final StreamRecentEarthquake _earthquakeFelt;

  RecentEarthquakeBloc(this._earthquakeFelt) : super(const _Initial()) {
    on<RecentEarthquakeEvent>((events, emit) async {
      await events.map(
        started: (_) => _onGetLastEarthquakeFelt(emit),
      );
    });
  }

  bool _isStarted = true;

  Future<void> _onGetLastEarthquakeFelt(
      Emitter<RecentEarthquakeState> emit) async {
    emit(state.copyWith(status: BlocState.loading));

    return _listenStream(emit);
  }

  Future<void> _listenStream(Emitter<RecentEarthquakeState> emit) {
    final streamData = _earthquakeFelt.call();

    final player = AudioPlayer();

    return emit.forEach(streamData, onData: (earthquake) {
      if (!_isStarted) {
        // if ((earthquake.magnitude ?? 3) > 4) {
        player.play(AssetSource('audio/General Earthquake.mp3'));
        // }
      }
      
      _isStarted = false;

      return state.copyWith(status: BlocState.success, earthquake: earthquake);
    }, onError: (e, s) {
      return state.copyWith(
          status: BlocState.failure,
          message: 'Tidak dapat mendapatkan gempa bumi terakhir');
    });
  }
}
