import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../../../domain/usecases/get_fault_line_usecase.dart';

part 'fault_line_data_state.dart';

class FaultLineDataCubit extends Cubit<FaultLineDataState> {
  final GetFaultLineUsecase _getFaultLineUsecase;

  FaultLineDataCubit(this._getFaultLineUsecase)
    : super(const FaultLineDataInitial());

  Future<void> getFaultLine() async {
    if (state is FaultLineDataLoaded) return;

    emit(const FaultLineDataLoading());
    try {
      final raw = await _getFaultLineUsecase();
      final decoded = await compute(decodeJson, raw);
      emit(FaultLineDataLoaded(decoded));
    } catch (_) {
      emit(const FaultLineDataFailure('Tidak dapat mendapatkan garis patahan'));
    }
  }
}
