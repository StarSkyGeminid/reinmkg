import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/usecases/geojson/get_provice_border_usecase.dart';

part 'region_border_state.dart';
part 'region_border_cubit.freezed.dart';

class RegionBorderCubit extends Cubit<ProvinceBorderState> {
  final GetProvinceBorderUsecase _getProvinceBorderUsecase;

  RegionBorderCubit(this._getProvinceBorderUsecase)
      : super(const ProvinceBorderState.initial());

  Future<void> getRegionBorder() {
    // return Future.value();

    emit(state.copyWith(status: BlocState.loading));

    return _getProvinceBorderUsecase().then((value) {
      value.fold(
        (l) => emit(state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan batas provinsi')),
        (r) =>
            emit(state.copyWith(status: BlocState.success, provinceBorder: r)),
      );
    });
  }
}
