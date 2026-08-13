import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../../../domain/usecases/get_province_border_usecase.dart';

part 'province_border_overlay_state.dart';

class ProvinceBorderOverlayCubit extends Cubit<ProvinceBorderOverlayState> {
  final GetProvinceBorderUsecase _getProvinceBorderUsecase;

  ProvinceBorderOverlayCubit(this._getProvinceBorderUsecase)
    : super(ProvinceBorderOverlayState());

  Future<void> getProvinceBorder() async {
    if (state.border != null) return;

    emit(ProvinceBorderOverlayState());

    try {
      final raw = await _getProvinceBorderUsecase();
      final decoded = await compute(decodeJson, raw);
      emit(ProvinceBorderOverlayState(border: decoded));
    } catch (_) {}
  }
}
