import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/maritime_weather_entity.dart';
import '../../../domain/usecases/get_maritime_weather_detail_usecase.dart';

part 'maritime_weather_detail_state.dart';

class MaritimeWeatherDetailCubit extends Cubit<MaritimeWeatherDetailState> {
  final GetMaritimeWeatherDetailUsecase _getMaritimeWeatherDetailUsecase;

  MaritimeWeatherDetailCubit(this._getMaritimeWeatherDetailUsecase)
    : super(MaritimeWeatherDetailInitial());

  Future<void> getDetails(String areaId) async {
    emit(MaritimeWeatherDetailLoading());
    try {
      final details = await _getMaritimeWeatherDetailUsecase(areaId);
      emit(MaritimeWeatherDetailLoaded(weatherDetails: details));
    } catch (e) {
      emit(MaritimeWeatherDetailFailure(message: e.toString()));
    }
  }
}
