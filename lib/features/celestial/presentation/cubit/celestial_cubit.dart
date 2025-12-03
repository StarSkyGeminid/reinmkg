import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/celestial_entity.dart';
import '../../domain/usecases/get_celestial_data_usecase.dart';

part 'celestial_state.dart';

class CelestialCubit extends Cubit<CelestialState> {
  final GetCelestialDataUsecase _getCelestialDataUsecase;

  CelestialCubit(this._getCelestialDataUsecase) : super(CelestialInitial());

  Future<void> getCelestialdata(DateTime dateTime, double latitude, double longitude) async {
    emit(CelestialLoading());

    try {
      final result = await _getCelestialDataUsecase.call(dateTime, latitude, longitude);
      emit(CelestialLoaded(result));
    } catch (e) {
      emit(CelestialFailure(e.toString()));
    }
  }
}
