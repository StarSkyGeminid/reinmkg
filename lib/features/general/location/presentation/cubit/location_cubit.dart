import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;
  final GetLastLocationUsecase _getLastLocationUsecase;
  final RefreshLocationUsecase _refreshLocationUsecase;

  LocationCubit(this._getCurrentLocationUsecase, this._getLastLocationUsecase, this._refreshLocationUsecase)
    : super(LocationInitial());

  String? _error;

  Future<void> getLocation() async {
    emit(LocationLoading());
    try {
      final location = await _getCurrentLocationUsecase();
      emit(LocationLoaded(location));
    } catch (e) {
      getLastLocation();
      _error = e.toString();
    }
  }

  Future<void> getLastLocation() async {
    emit(LocationLoading());
    try {
      final location = await _getLastLocationUsecase();
      emit(LocationLoaded(location, isFromLast: true));
    } catch (e) {
      emit(LocationFailure(_error ?? e.toString()));
    }
  }

  Future<void> refreshLocation() async {
    emit(LocationLoading());
    try {
      final location = await _refreshLocationUsecase();
      emit(LocationLoaded(location));
    } catch (e) {
      emit(LocationFailure(e.toString()));
    }
  }
}
