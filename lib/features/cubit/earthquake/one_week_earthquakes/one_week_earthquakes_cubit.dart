import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/domain.dart';

part 'one_week_earthquakes_state.dart';
part 'one_week_earthquakes_cubit.freezed.dart';

class OneWeekEarthquakesCubit extends Cubit<OneWeekEarthquakesState> {
  final GetOneWeekEarthquakes _getOneWeekEarthquakes;

  OneWeekEarthquakesCubit(this._getOneWeekEarthquakes)
      : super(const OneWeekEarthquakesState());

  Future<void> getEarthquakes() async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _getOneWeekEarthquakes();

    result.fold(
      (l) => emit(state.copyWith(
          status: BlocState.failure,
          message: 'Tidak dapat mendapatkan gempa bumi mingguan')),
      (r) => emit(state.copyWith(status: BlocState.success, earthquakes: r)),
    );
  }
}
