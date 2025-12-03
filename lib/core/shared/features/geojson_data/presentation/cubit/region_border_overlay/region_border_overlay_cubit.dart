import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_region_border_usecase.dart';

part 'region_border_overlay_state.dart';

class RegionBorderOverlayCubit extends Cubit<RegionBorderOverlayState> {
  final GetRegionBorderUsecase _getProvinceBorderUsecase;

  RegionBorderOverlayCubit(this._getProvinceBorderUsecase)
    : super(RegionBorderOverlayState());

  Future<void> getRegionBorder() {
    emit(RegionBorderOverlayState());

    return _getProvinceBorderUsecase()
        .then((value) {
          emit(RegionBorderOverlayState(border: value));
        })
        .catchError((error) {});
  }
}
