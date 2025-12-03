import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/water_wave_entity.dart';
import '../../../domain/usecases/get_water_waves_usecase.dart';

part 'maritime_weather_state.dart';

class MaritimeWeatherCubit extends Cubit<MaritimeWeatherState> {
  final GetWaterWavesUsecase _getWaterWavesUsecase;

  MaritimeWeatherCubit(this._getWaterWavesUsecase)
    : super(MaritimeWeatherInitial());

  Future<void> load() async {
    emit(MaritimeWeatherLoading());
    try {
      final waves = await _getWaterWavesUsecase();
      emit(MaritimeWeatherLoaded(waves: waves));
    } catch (e) {
      emit(MaritimeWeatherFailure(message: e.toString()));
    }
  }
}
