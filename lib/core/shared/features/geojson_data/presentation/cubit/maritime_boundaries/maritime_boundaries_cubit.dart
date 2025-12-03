import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_maritime_boundaries_usecase.dart';

part 'maritime_boundaries_state.dart';

class MaritimeBoundariesCubit extends Cubit<MaritimeBoundariesState> {
  final GetMaritimeBoundariesUsecase _getMaritimeBoundariesUsecase;

  MaritimeBoundariesCubit(this._getMaritimeBoundariesUsecase)
    : super(MaritimeBoundariesState());

  Future<void> fetchMaritimeBoundaries() async {
    try {
      final boundaries = await _getMaritimeBoundariesUsecase.call();
      emit(MaritimeBoundariesState(boundaries: boundaries));
    } catch (e) {
      emit(MaritimeBoundariesState(boundaries: null));
    }
  }
}
