import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reinmkg/core/enumerate/bloc_state.dart';
import 'package:reinmkg/utils/helper/common.dart';

import '../../../../domain/entities/weather/water_wave_entity.dart';
import '../../../../domain/usecases/weather/get_water_wave_usecase.dart';

part 'water_wave_state.dart';
part 'water_wave_cubit.freezed.dart';

class WaterWaveCubit extends Cubit<WaterWaveState> {
  final GetWaterWave _getWaterWave;

  WaterWaveCubit(this._getWaterWave) : super(const WaterWaveState.initial());

  Future<void> getWaterWaves() async {
    emit(state.copyWith(status: BlocState.loading));
    log.d('getting water waves');

    final result = await _getWaterWave();

    log.d(result.toString());

    if (isClosed) return;

    result.fold(
      (l) => emit(
        state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan data gelombang laut'),
      ),
      (r) => emit(state.copyWith(
        status: BlocState.success,
        waves: r,
      )),
    );
  }
}
