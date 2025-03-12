import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reinmkg/domain/domain.dart';

import '../../../core/enumerate/bloc_state.dart';

part 'location_state.dart';
part 'location_cubit.freezed.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetCurrentLocation _getLocationUsecase;

  LocationCubit(this._getLocationUsecase) : super(const LocationState());

  Future<void> getLocation() async {
    emit(state.copyWith(status: BlocState.loading));

    final location = await _getLocationUsecase.call();

    return location.fold(
      (l) => emit(state.copyWith(
          status: BlocState.failure,
          message: 'Tidak dapat mendapatkan lokasi')),
      (r) => emit(state.copyWith(status: BlocState.success, location: r)),
    );
  }
}
