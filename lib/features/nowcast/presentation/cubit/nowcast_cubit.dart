import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/weather_nowcast_entity.dart';
import '../../domain/usecases/get_nowcasts_usecase.dart';

part 'nowcast_state.dart';

class NowcastCubit extends Cubit<NowcastState> {
  final GetNowcastsUsecase _getNowcastsUsecase;

  NowcastCubit(this._getNowcastsUsecase) : super(NowcastInitial());

  Future<void> getNowcasts() async {
    emit(NowcastLoading());
    try {
      final nowcasts = await _getNowcastsUsecase();
      emit(NowcastLoaded(nowcasts));
    } catch (e) {
      emit(NowcastFailure(e.toString()));
    }
  }
}
