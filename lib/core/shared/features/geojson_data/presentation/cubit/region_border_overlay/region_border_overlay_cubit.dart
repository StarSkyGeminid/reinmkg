import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';

import '../../../domain/usecases/get_region_border_usecase.dart';

part 'region_border_overlay_state.dart';

class RegionBorderOverlayCubit extends Cubit<RegionBorderOverlayState> {
  final GetRegionBorderUsecase _getProvinceBorderUsecase;

  RegionBorderOverlayCubit(this._getProvinceBorderUsecase)
    : super(RegionBorderOverlayState());

  Future<void> getRegionBorder() async {
    if (state.border != null) return;

    emit(RegionBorderOverlayState());

    try {
      final raw = await _getProvinceBorderUsecase();
      final decoded = await compute(decodeJson, raw);
      emit(RegionBorderOverlayState(border: decoded));
    } catch (_) {}
  }
}
