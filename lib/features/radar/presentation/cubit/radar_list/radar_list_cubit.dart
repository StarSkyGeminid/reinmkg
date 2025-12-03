import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/get_all_radars_usecase.dart';
import '../../../domain/usecases/search_radars_usecase.dart';

part 'radar_list_state.dart';

class RadarListCubit extends Cubit<RadarListState> {
  final GetAllRadarsUsecase _getRadars;
  final SearchRadarsUsecase _searchRadars;

  RadarListCubit(this._getRadars, this._searchRadars)
    : super(RadarListInitial());

  Future<void> load() async {
    emit(RadarListLoading());
    try {
      final radars = await _getRadars.call();

      emit(RadarListLoaded(radars: radars));
    } catch (e) {
      emit(RadarListFailure(e.toString()));
    }
  }

  Future<void> search(String query) async {
    emit(RadarListLoading());
    try {
      final radars = await _searchRadars.call(query);

      emit(RadarListLoaded(radars: radars));
    } catch (e) {
      emit(RadarListFailure(e.toString()));
    }
  }
}
