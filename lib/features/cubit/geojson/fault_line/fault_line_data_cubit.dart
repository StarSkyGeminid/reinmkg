import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/usecases/geojson/get_fault_line_usecase.dart';

part 'fault_line_data_state.dart';
part 'fault_line_data_cubit.freezed.dart';

class FaultLineDataCubit extends Cubit<FaultLineDataState> {
  final GetFaultLineUsecase _getFaultLineUsecase;

  FaultLineDataCubit(this._getFaultLineUsecase)
      : super(const FaultLineDataState.initial());

  Future<void> getFaultLine() {
    // return Future.value();
    emit(state.copyWith(status: BlocState.loading));

    return _getFaultLineUsecase().then((value) {
      value.fold(
        (l) => emit(
          state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan garis patahan',
          ),
        ),
        (r) => emit(state.copyWith(
          status: BlocState.success,
          faultLine: r,
        )),
      );
    });
  }
}
