import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reinmkg/core/enumerate/bloc_state.dart';

import '../../../../domain/domain.dart';


part 'satelite_images_state.dart';
part 'satelite_images_cubit.freezed.dart';

class SateliteImagesCubit extends Cubit<SateliteImagesState> {
  final GetSateliteImages _getSateliteImages;

  SateliteImagesCubit(this._getSateliteImages)
      : super(const SateliteImagesState.initial());

  Future<void> getSateliteImages() async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _getSateliteImages();

    result.fold(
      (l) => emit(
        state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan cuaca harian'),
      ),
      (r) => emit(state.copyWith(
        status: BlocState.success,
        images: r,
      )),
    );
  }
}
