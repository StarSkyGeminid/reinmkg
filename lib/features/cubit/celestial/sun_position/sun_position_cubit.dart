import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/entities/celestial/celestial_entity.dart';
import '../../../../domain/entities/location/location_entity.dart';
import '../../../../domain/usecases/celestial/get_sun_data_usecase.dart';

part 'sun_position_state.dart';
part 'sun_position_cubit.freezed.dart';

class SunPositionCubit extends Cubit<SunPositionState> {
  final GetSunData _getSunData;

  SunPositionCubit(this._getSunData) : super(const SunPositionState.initial());

  Future<void> getSunData(LocationEntity entity) async {
    final result = await _getSunData.call(params: entity);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: BlocState.failure,
          message: l.toString(),
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BlocState.success,
          position: r,
        ),
      ),
    );
  }
}
