import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/earthquake_entity.dart';
import '../../../domain/enumerates/earthquakes_type.dart';
import '../../../domain/usecases/get_earthquakes_by_type_usecase.dart';

part 'earthquake_history_by_type_state.dart';

class EarthquakeHistoryByTypeCubit extends Cubit<EarthquakeHistoryByTypeState> {
  final GetEarthquakesByType _getByType;

  EarthquakeHistoryByTypeCubit(this._getByType)
    : super(EarthquakeHistoryByTypeInitial());

  Future<void> getEarthquakes(EarthquakesType type) async {
    try {
      emit(EarthquakeHistoryByTypeLoading());
      final data = await _getByType.call(type);

      if (isClosed) return;

      emit(EarthquakeHistoryByTypeLoaded(data));
    } catch (e) {
      emit(EarthquakeHistoryByTypeFailure(e.toString()));
    }
  }
}
