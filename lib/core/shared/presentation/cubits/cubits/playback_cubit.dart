import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'playback_state.dart';

class PlaybackCubit extends Cubit<PlaybackState> {
  Timer? _timer;
  int _maxIndex;

  int get maxIndex => _maxIndex;

  PlaybackCubit({int initialMaxIndex = 1})
    : _maxIndex = initialMaxIndex,
      super(const PlaybackState(index: 0, playing: false));

  void setMaxIndex(int newMax) {
    newMax = newMax - 1;

    final nm = newMax < 0 ? 0 : newMax;

    if (nm == _maxIndex) return;

    _maxIndex = nm;

    emit(PlaybackState(index: _maxIndex, playing: false));
  }

  void setIndex(int idx) {
    final clamped = idx.clamp(0, _maxIndex);
    emit(PlaybackState(index: clamped, playing: state.playing));
  }

  void next() {
    final nextIndex = (state.index + 1).clamp(0, _maxIndex);
    emit(PlaybackState(index: nextIndex, playing: state.playing));
  }

  void previous() {
    final prev = (state.index - 1).clamp(0, _maxIndex);
    emit(PlaybackState(index: prev, playing: state.playing));
  }

  void playPause({Duration step = const Duration(seconds: 1)}) {
    if (state.playing) {
      _timer?.cancel();
      _timer = null;
      emit(PlaybackState(index: state.index, playing: false));
      return;
    }

    emit(PlaybackState(index: state.index, playing: true));
    _timer = Timer.periodic(step, (_) {
      int index = state.index + 1;
      if (index > _maxIndex) {
        index = 0;
      }
      emit(PlaybackState(index: index, playing: true));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
