import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/entities/celestial/celestial_entity.dart';
import '../../../../domain/entities/location/location_entity.dart';
import '../../../../domain/usecases/celestial/get_moon_data_usecase.dart';

part 'moon_position_state.dart';
part 'moon_position_cubit.freezed.dart';

class MoonPositionCubit extends Cubit<MoonPositionState> {
  final GetMoonData _getMoonData;

  MoonPositionCubit(this._getMoonData)
      : super(const MoonPositionState.initial());

  Future<void> getMoonData(LocationEntity entity) async {
    final result = await _getMoonData.call(params: entity);

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
