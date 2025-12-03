import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/earthquake_entity.dart';
import '../../../domain/usecases/get_earthquake_histories_usecase.dart';

part 'earthquake_histories_state.dart';

class EarthquakeHistoriesCubit extends Cubit<EarthquakeHistoriesState> {
  final GetEarthquakeHistories _getHistories;

  EarthquakeHistoriesCubit(this._getHistories)
    : super(EarthquakeHistoriesInitial());

  Future<void> getHistories() async {
    try {
      emit(EarthquakeHistoriesLoading());
      final data = await _getHistories.call();
      emit(EarthquakeHistoriesLoaded(data));
    } catch (e) {
      emit(EarthquakeHistoriesFailure(e.toString()));
    }
  }
}
