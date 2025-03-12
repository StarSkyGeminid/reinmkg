import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../domain/entities/weather/radar/radar_entity.dart';
import '../../../../domain/usecases/weather/radar/get_cloud_radars_usecase.dart';

part 'search_cloud_radar_event.dart';
part 'search_cloud_radar_state.dart';
part 'search_cloud_radar_bloc.freezed.dart';

class SearchCloudRadarBloc
    extends Bloc<SearchCloudRadarEvent, SearchCloudRadarState> {
  final GetCloudRadars _getCloudRadar;

  SearchCloudRadarBloc(this._getCloudRadar) : super(const _Initial()) {
    on<SearchCloudRadarEvent>((events, emit) async {
      await events.map(
        started: (_) async => await getCloudRadars(emit),
        search: (event) async => await _onSearch(event, emit),
      );
    });
  }

  List<RadarEntity> allRadars = [];

  Future<void> getCloudRadars(Emitter<SearchCloudRadarState> emit) async {
    emit(state.copyWith(status: BlocState.loading));

    final result = await _getCloudRadar();

    result.fold(
      (l) => emit(
        state.copyWith(
            status: BlocState.failure,
            message: 'Tidak dapat mendapatkan citra radar'),
      ),
      (r) {
        allRadars = r;

        emit(state.copyWith(
          status: BlocState.success,
          radars: r,
        ));
      },
    );
  }

  Future<void> _onSearch(
      _Search event, Emitter<SearchCloudRadarState> emit) async {
    emit(state.copyWith(status: BlocState.loading));

    if (event.query.isEmpty) {
      emit(state.copyWith(
        status: BlocState.success,
        radars: allRadars,
      ));
    } else {
      if (allRadars.isEmpty) {
        return emit(state.copyWith(
          status: BlocState.success,
          radars: allRadars,
        ));
      }

      final filteredRadar = allRadars
          .where((location) =>
              location.city
                  ?.toLowerCase()
                  .contains(event.query.toLowerCase()) ??
              false)
          .toList();

      return emit(state.copyWith(
        status: BlocState.success,
        radars: filteredRadar,
      ));
    }
  }
}
