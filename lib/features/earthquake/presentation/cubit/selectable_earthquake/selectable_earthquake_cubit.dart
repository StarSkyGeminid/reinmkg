import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/earthquake_entity.dart';
import '../../../domain/usecases/set_selected_earthquake_usecase.dart';
import '../../../domain/usecases/watch_selected_earthquake_usecase.dart';

part 'selectable_earthquake_state.dart';

class SelectableEarthquakeCubit extends Cubit<SelectableEarthquakeState> {
  final SetSelectedEarthquake _setSelected;
  final WatchSelectedEarthquake _watchSelected;

  StreamSubscription<EarthquakeEntity>? _sub;

  SelectableEarthquakeCubit(this._setSelected, this._watchSelected)
    : super(SelectableEarthquakeInitial());

  void startListening() {
    _sub ??= _watchSelected.call().listen(
      (event) {
        emit(SelectableEarthquakeSelected(event));
      },
      onError: (e) {
        emit(SelectableEarthquakeFailure(e.toString()));
      },
    );
  }

  void setSelected(EarthquakeEntity entity) {
    emit(SelectableEarthquakeLoading());
    try {
      _setSelected.call(entity);
      emit(SelectableEarthquakeSelected(entity));
    } catch (e) {
      emit(SelectableEarthquakeFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
