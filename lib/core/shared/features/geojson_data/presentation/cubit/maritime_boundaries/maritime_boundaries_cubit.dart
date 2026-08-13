import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../../../domain/usecases/get_maritime_boundaries_usecase.dart';

part 'maritime_boundaries_state.dart';

class MaritimeBoundariesCubit extends Cubit<MaritimeBoundariesState> {
  final GetMaritimeBoundariesUsecase _getMaritimeBoundariesUsecase;

  MaritimeBoundariesCubit(this._getMaritimeBoundariesUsecase)
    : super(MaritimeBoundariesState());

  Future<void> fetchMaritimeBoundaries() async {
    if (state.boundaries != null) return;

    try {
      final raw = await _getMaritimeBoundariesUsecase.call();
      final decoded = await compute(decodeJson, raw);
      emit(MaritimeBoundariesState(boundaries: decoded));
    } catch (e) {
      emit(MaritimeBoundariesState(boundaries: null));
    }
  }
}
