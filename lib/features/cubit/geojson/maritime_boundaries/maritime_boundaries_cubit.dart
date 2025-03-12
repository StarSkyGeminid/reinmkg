import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/usecases/geojson/get_maritime_boundaries_usecase.dart';

part 'maritime_boundaries_state.dart';
part 'maritime_boundaries_cubit.freezed.dart';

class MaritimeBoundariesCubit extends Cubit<MaritimeBoundariesState> {
  final GetMaritimeBoundariesUsecase _getMaritimeBoundariesUsecase;

  MaritimeBoundariesCubit(this._getMaritimeBoundariesUsecase)
      : super(const MaritimeBoundariesState.initial());

  Future<void> getMaritimeBoundaries() {
    // return Future.value();

    emit(state.copyWith(status: BlocState.loading));

    return _getMaritimeBoundariesUsecase.call().then((value) {
      value.fold(
        (l) => emit(state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan batas provinsi')),
        (r) => emit(state.copyWith(status: BlocState.success, boundaries: r)),
      );
    });
  }
}
