import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../core/enumerate/earthquakes_type.dart';
import '../../../../domain/domain.dart';

part 'earthquake_history_by_type_state.dart';
part 'earthquake_history_by_type_cubit.freezed.dart';

class EarthquakeHistoryByTypeCubit extends Cubit<EarthquakeHistoryByTypeState> {
  final GetEarthquakesByTypeUsecase _getEarthquakesByTypeUsecase;

  EarthquakeHistoryByTypeCubit(this._getEarthquakesByTypeUsecase)
      : super(const EarthquakeHistoryByTypeState.initial());

  Future<void> getEarthquakes(EarthquakesType type) async {
    emit(state.copyWith(
      status: BlocState.loading,
      earthquakes: [],
    ));

    final result = await _getEarthquakesByTypeUsecase(params: type);

    if (isClosed) return;

    return result.fold(
      (l) => emit(
        state.copyWith(
          status: BlocState.failure,
          message: 'Tidak dapat mendapatkan data gempa bumi',
          earthquakes: [],
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BlocState.success,
          earthquakes: r,
        ),
      ),
    );
  }
}
