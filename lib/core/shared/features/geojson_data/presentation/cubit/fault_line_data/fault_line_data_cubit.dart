import 'package:bloc/bloc.dart';

import '../../../domain/usecases/get_fault_line_usecase.dart';

part 'fault_line_data_state.dart';

class FaultLineDataCubit extends Cubit<FaultLineDataState> {
  final GetFaultLineUsecase _getFaultLineUsecase;

  FaultLineDataCubit(this._getFaultLineUsecase)
    : super(const FaultLineDataInitial());

  Future<void> getFaultLine() async {
    emit(const FaultLineDataLoading());
    try {
      final value = await _getFaultLineUsecase();
      emit(FaultLineDataLoaded(value));
    } catch (_) {
      emit(const FaultLineDataFailure('Tidak dapat mendapatkan garis patahan'));
    }
  }
}
