import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/radar_entity.dart';
import '../../../domain/entities/radar_image_entity.dart';
import '../../../domain/enumerate/radar_type.dart';
import '../../../domain/usecases/get_nearest_radar_usecase.dart';
import '../../../domain/usecases/set_radar_type_usecase.dart';
import '../../../domain/usecases/set_radar_usecase.dart';
import '../../../domain/usecases/watch_radars_images_usecase.dart';

part 'radar_selection_state.dart';

class RadarSelectionCubit extends Cubit<RadarSelectionState> {
  final GetNearestRadarUsecase _getNearestRadarUsecase;
  final SetRadarUsecase _setRadarUsecase;
  final SetRadarTypeUsecase _setRadarTypeUsecase;
  final WatchRadarImagesUsecase _watchRadarImagesUsecase;

  StreamSubscription<List<RadarImageEntity>>? _watchSub;

  RadarEntity? _radar;
  RadarType _type = RadarType.cmax;

  RadarSelectionCubit(
    this._getNearestRadarUsecase,
    this._setRadarUsecase,
    this._setRadarTypeUsecase,
    this._watchRadarImagesUsecase,
  ) : super(RadarSelectionInitial());

  Future<void> load(double latitude, double longitude) async {
    try {
      final radar = await _getNearestRadarUsecase.call(latitude, longitude);
      _radar = radar;

      await _setRadarUsecase.call(radar);
      await _setRadarTypeUsecase.call(_type);

      watch();
    } catch (e) {
      emit(const RadarSelectionFailure("Failed to load radar selection"));
    }
  }

  void select(RadarEntity radar) {
    _setRadarUsecase.call(radar);

    _radar = radar;

    watch();
  }

  void changeType(RadarType type) {
    _setRadarTypeUsecase.call(type);

    _type = type;

    watch();
  }

  Future<void> watch() async {
    _watchSub?.cancel();
    _watchSub = _watchRadarImagesUsecase.call().listen(
      (images) {
        emit(RadarSelectionLoaded(radar: _radar!, images: images, type: _type));
      },
      onError: (err) {
        emit(RadarSelectionFailure(err.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _watchSub?.cancel();
    return super.close();
  }
}
