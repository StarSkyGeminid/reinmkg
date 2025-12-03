import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/earthquake_pga_entity.dart';
import '../../domain/usecases/get_earthquake_pga_data_usecase.dart';

part 'seismic_playback_state.dart';

class SeismicPlaybackCubit extends Cubit<SeismicPlaybackState> {
  final GetEarthquakePgaDataUsecase _getPgaData;
  Timer? _ticker;
  DateTime? _baseTime;

  SeismicPlaybackCubit(this._getPgaData) : super(const SeismicPlaybackState());

  Future<void> load(String eventId, {DateTime? baseTime}) async {
    emit(state.copyWith(isLoading: true, message: null));
    try {
      final list = await _getPgaData.call(eventId);

      if (list.isEmpty) {
        emit(state.copyWith(isLoading: false, message: 'No PGA data'));
        return;
      }

      final earliest = list
          .where((e) => e.timestamp != null)
          .map((e) => e.timestamp!)
          .fold<DateTime?>(
            null,
            (prev, elem) => prev == null || elem.isBefore(prev) ? elem : prev,
          );

      _baseTime = baseTime ?? earliest ?? DateTime.now();

      _baseTime = _baseTime?.subtract(const Duration(seconds: 1));

      double maxOffset = 0.0;
      for (final e in list) {
        if (e.timestamp != null) {
          final offset =
              e.timestamp!.difference(_baseTime!).inMilliseconds / 1000.0;
          if (offset > maxOffset) maxOffset = offset;
        }
      }

      emit(
        state.copyWith(
          isLoading: false,
          isPlaying: false,
          pgaList: list,
          positionSeconds: 0.0,
          durationSeconds: maxOffset,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, message: e.toString()));
    }
  }

  void _tick() {
    final next = state.positionSeconds + 0.5;
    if (next >= state.durationSeconds) {
      _stopTicker();
      emit(
        state.copyWith(
          isPlaying: false,
          positionSeconds: state.durationSeconds,
        ),
      );
    } else {
      emit(state.copyWith(positionSeconds: next));
    }
  }

  void play() {
    if (state.isPlaying) return;
    _ticker ??= Timer.periodic(
      const Duration(milliseconds: 500),
      (_) => _tick(),
    );

    double positionSeconds = state.positionSeconds;

    if (state.positionSeconds >= state.durationSeconds) {
      positionSeconds = 0.0;
    }

    emit(state.copyWith(isPlaying: true, positionSeconds: positionSeconds));
  }

  void pause() {
    if (!state.isPlaying) return;
    _stopTicker();
    emit(state.copyWith(isPlaying: false));
  }

  void seek(double seconds) {
    final pos = seconds.clamp(0.0, state.durationSeconds);
    emit(state.copyWith(positionSeconds: pos));
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  List<EarthquakePgaEntity> activePga(double atSeconds) {
    if (_baseTime == null) return [];
    return state.pgaList.where((e) {
      if (e.timestamp == null) return false;
      final offset =
          e.timestamp!.difference(_baseTime!).inMilliseconds / 1000.0;
      return offset <= atSeconds;
    }).toList();
  }

  @override
  Future<void> close() {
    _stopTicker();
    return super.close();
  }
}
