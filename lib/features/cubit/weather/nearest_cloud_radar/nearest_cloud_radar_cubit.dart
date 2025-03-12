import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/entities/weather/radar/radar_entity.dart';
import '../../../../domain/usecases/weather/radar/get_nearest_cloud_radar_usecase.dart';

part 'nearest_cloud_radar_state.dart';
part 'nearest_cloud_radar_cubit.freezed.dart';

class NearestCloudRadarCubit extends Cubit<NearestCloudRadarState> {
  final GetNearestCloudRadar _nearestRadarImage;

  NearestCloudRadarCubit(this._nearestRadarImage)
      : super(const NearestCloudRadarState.initial());

  Future<void> getNearestCloudRadar(LatLng location) async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _nearestRadarImage(params: location);

    result.fold(
      (l) => emit(
        state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan citra radar'),
      ),
      (r) => emit(state.copyWith(
        status: BlocState.success,
        radar: r,
      )),
    );
  }
}
