import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/satelite_entity.dart';
import '../../domain/usecases/get_satelite_images_usecase.dart';

part 'satelite_state.dart';

class SateliteCubit extends Cubit<SateliteState> {
  final GetSateliteImagesUsecase _getSateliteImagesUsecase;

  SateliteCubit(this._getSateliteImagesUsecase) : super(SateliteInitial());

  Future<void> getImages() async {
    if (isClosed) return;
    emit(SateliteLoading());
    try {
      final sateliteImages = await _getSateliteImagesUsecase();
      if (isClosed) return;
      emit(SateliteLoaded(sateliteImages));
    } catch (e) {
      if (isClosed) return;
      emit(SateliteFailure(e.toString()));
    }
  }
}
