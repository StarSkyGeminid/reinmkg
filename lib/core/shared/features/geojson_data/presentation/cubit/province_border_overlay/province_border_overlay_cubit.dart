import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_province_border_usecase.dart';

part 'province_border_overlay_state.dart';

class ProvinceBorderOverlayCubit extends Cubit<ProvinceBorderOverlayState> {
  final GetProvinceBorderUsecase _getProvinceBorderUsecase;

  ProvinceBorderOverlayCubit(this._getProvinceBorderUsecase)
    : super(ProvinceBorderOverlayState());

  Future<void> getProvinceBorder() {
    emit(ProvinceBorderOverlayState());

    return _getProvinceBorderUsecase()
        .then((value) {
          emit(ProvinceBorderOverlayState(border: value));
        })
        .catchError((error) {});
  }
}
