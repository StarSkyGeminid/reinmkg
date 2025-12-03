import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/satelite_entity.dart';
import '../../domain/usecases/get_satelite_images_usecase.dart';

part 'satelite_state.dart';

class SateliteCubit extends Cubit<SateliteState> {
  final GetSateliteImagesUsecase _getSateliteImagesUsecase;

  SateliteCubit(this._getSateliteImagesUsecase) : super(SateliteInitial());

  Future<void> getImages() async {
    emit(SateliteLoading());
    try {
      final sateliteImages = await _getSateliteImagesUsecase();
      emit(SateliteLoaded(sateliteImages));
    } catch (e) {
      emit(SateliteFailure(e.toString()));
    }
  }
}
