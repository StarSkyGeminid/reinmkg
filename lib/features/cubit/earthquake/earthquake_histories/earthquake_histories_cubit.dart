import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/entities/earthquake/earthquake_entity.dart';
import '../../../../domain/usecases/earthquake/get_earthquake_histories_usecase.dart';

part 'earthquake_histories_state.dart';
part 'earthquake_histories_cubit.freezed.dart';

class EarthquakeHistoriesCubit extends Cubit<EarthquakeHistoriesState> {
  final GetEarthquakeHistories _earthquakeHistories;

  EarthquakeHistoriesCubit(this._earthquakeHistories)
      : super(const EarthquakeHistoriesState.initial());

  Future<void> getEarthquakes() async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _earthquakeHistories();

    result.fold(
      (l) => emit(state.copyWith(
          status: BlocState.failure,
          message: 'Tidak dapat mendapatkan gempa bumi mingguan')),
      (r) => emit(state.copyWith(status: BlocState.success, earthquakes: r)),
    );
  }
}
