import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reinmkg/domain/domain.dart';

import '../../../../core/enumerate/bloc_state.dart';

part 'selectable_earthquake_event.dart';
part 'selectable_earthquake_state.dart';
part 'selectable_earthquake_bloc.freezed.dart';

class SelectableEarthquakeBloc
    extends Bloc<SelectableEarthquakeEvent, SelectableEarthquakeState> {
  final GetSelectedEarthquake _getSelected;
  final SetSelectedEarthquake _setSelected;

  SelectableEarthquakeBloc(
      this._getSelected, this._setSelected)
      : super(const _Initial()) {
    on<SelectableEarthquakeEvent>((events, emit) async {
      await events.map(
        started: (_) async => await _onSubscriptionRequested(emit),
        setEarthquake: (event) async =>
            await _onChangeSelectionRequested(event, emit),
      );
    });
  }

  Future<void> _onSubscriptionRequested(
    Emitter<SelectableEarthquakeState> emit,
  ) async {
    emit(state.copyWith(status: BlocState.loading));

    await emit.forEach<EarthquakeEntity>(
      _getSelected.call(),
      onData: (earthquake) => state.copyWith(
        status: BlocState.success,
        earthquake: earthquake,
      ),
      onError: (_, __) => state.copyWith(status: BlocState.failure),
    );
  }

  Future<void> _onChangeSelectionRequested(
    _SetEarthquake event,
    Emitter<SelectableEarthquakeState> emit,
  ) async {
    emit(state.copyWith(status: BlocState.loading));

    _setSelected.call(params: event.earthquakeEntity);
  }
}
