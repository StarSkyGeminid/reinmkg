import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/entities/weather/radar/radar_entity.dart';
import '../../../../domain/usecases/weather/radar/get_cloud_radars_usecase.dart';

part 'cloud_radars_state.dart';
part 'cloud_radars_cubit.freezed.dart';

class CloudRadarsCubit extends Cubit<CloudRadarsState> {
  final GetCloudRadars _getCloudRadar;

  CloudRadarsCubit(this._getCloudRadar)
      : super(const CloudRadarsState.initial());

  Future<void> getCloudRadars() async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _getCloudRadar();

    result.fold(
      (l) => emit(
        state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan citra radar'),
      ),
      (r) => emit(state.copyWith(
        status: BlocState.success,
        images: r,
      )),
    );
  }
}
