import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reinmkg/core/enumerate/bloc_state.dart';
import 'package:reinmkg/domain/entities/weather/radar/radar_entity.dart';
import 'package:reinmkg/domain/usecases/weather/weather.dart';

import '../../../../core/enumerate/radar_type.dart';
import '../../../../domain/entities/weather/radar/radar_image_entity.dart';

part 'selectable_radar_event.dart';
part 'selectable_radar_state.dart';
part 'selectable_radar_bloc.freezed.dart';

class SelectableRadarBloc
    extends Bloc<SelectableRadarEvent, SelectableRadarState> {
  final SetSelectedRadar _setSelectedRadar;
  final StreamSelectedRadar _getSelectedRadar;

  SelectableRadarBloc(this._setSelectedRadar, this._getSelectedRadar)
      : super(const _Initial()) {
    on<SelectableRadarEvent>((events, emit) async {
      await events.map(
        started: (_) async => await _onSubscriptionRequested(emit),
        setRadar: (event) async =>
            await _onChangeSelectionRequested(event, emit),
        sliderChanged: (event) async => _onSliderChanged(event, emit),
        setRadarType: (event) async => _onTypeChanged(event, emit),
        play: (_) async => await _onPlay(emit),
        previous: (_) async => _onPrevious(emit),
        next: (_) async => _onNext(emit),
      );
    });
  }

  Timer? timer;

  Future<void> _onSubscriptionRequested(
    Emitter<SelectableRadarState> emit,
  ) async {
    emit(state.copyWith(status: BlocState.loading));

    await emit.forEach<RadarEntity>(
      _getSelectedRadar.call(),
      onData: (radar) {
        final images = radar.file?.where((e) => e.type == state.type).toList();

        return state.copyWith(
          status: BlocState.success,
          selectedRadar: radar,
          radarImages: images,
          selectedRadarImages: images?.last,
          currentIndex: images?.length ?? 0
        );
      },
      onError: (_, __) => state.copyWith(status: BlocState.failure),
    );
  }

  Future<void> _onChangeSelectionRequested(
    _SetRadar event,
    Emitter<SelectableRadarState> emit,
  ) async {
    emit(state.copyWith(status: BlocState.loading));

    _setSelectedRadar.call(params: event.entity);
  }

  Future<void> _onTypeChanged(
    _RadarType event,
    Emitter<SelectableRadarState> emit,
  ) async {
    emit(state.copyWith(status: BlocState.loading));

    final images = state.selectedRadar?.file
        ?.where(
          (e) => e.type == event.type,
        )
        .toList();

    emit(state.copyWith(
      status: BlocState.success,
      radarImages: images,
      selectedRadarImages: images?.last,
      type: event.type,
    ));
  }

  Future<void> _onPlay(Emitter<SelectableRadarState> emit) async {
    if (timer != null) {
      timer?.cancel();
      timer = null;

      emit(state.copyWith(isPlaying: false));
      return;
    }

    emit(state.copyWith(isPlaying: true));

    timer = makePeriodicCall(const Duration(seconds: 2), (Timer t) async {
      add(state.dirRight ? const _Next() : const _Previous());
    });
  }

  void _onNext(Emitter<SelectableRadarState> emit) {
    emit(state.copyWith(dirRight: true));

    _handleSelectedRadarImage(emit, state.currentIndex);
  }

  void _onPrevious(Emitter<SelectableRadarState> emit) {
    emit(state.copyWith(dirRight: false));

    _handleSelectedRadarImage(emit, state.currentIndex);
  }

  void _onSliderChanged(
      _SliderChanged event, Emitter<SelectableRadarState> emit) {
    _handleSelectedRadarImage(emit, event.index);
  }

  void _handleSelectedRadarImage(
      Emitter<SelectableRadarState> emit, int currentIndex) {
    if (state.dirRight) {
      currentIndex =
          currentIndex < (state.radarImages?.length ?? 0) ? currentIndex : 0;
    } else {
      currentIndex = currentIndex > 0
          ? currentIndex
          : (state.radarImages?.length ?? 1) - 1;
    }

    emit(state.copyWith(
      selectedRadarImages: state.radarImages?[currentIndex],
      currentIndex: state.dirRight ? currentIndex + 1 : currentIndex - 1,
    ));
  }

  @override
  Future<void> close() async {
    timer?.cancel();
    timer = null;
    return super.close();
  }

  Timer makePeriodicCall(
    Duration duration,
    void Function(Timer timer) callback, {
    bool fireNow = false,
  }) {
    var timer = Timer.periodic(duration, callback);
    if (state.isPlaying) {
      callback(timer);
    }
    return timer;
  }
}
