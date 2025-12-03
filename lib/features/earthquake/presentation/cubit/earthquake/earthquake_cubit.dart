import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/earthquake_entity.dart';
import '../../../domain/usecases/get_last_earthquake_felt_usecase.dart';
import '../../../domain/usecases/get_recent_earthquake_usecase.dart';
import '../../../domain/usecases/watch_recent_earthquake_usecase.dart';
import '../../../domain/usecases/watch_last_earthquake_felt_usecase.dart';

part 'earthquake_state.dart';

class EarthquakeCubit extends Cubit<EarthquakeState> {
  final GetLastEarthquakeFelt _getLast;
  final GetRecentEarthquake _getRecent;
  final WatchLastEarthquakeFelt _watchLast;
  final WatchRecentEarthquake _watchRecent;

  StreamSubscription<EarthquakeEntity>? _lastSub;
  StreamSubscription<EarthquakeEntity>? _recentSub;

  EarthquakeCubit(
    this._getLast,
    this._getRecent,
    this._watchLast,
    this._watchRecent,
  ) : super(EarthquakeInitial());

  Stream<EarthquakeEntity> get lastEarthquakeStream => _watchLast.call();

  Stream<EarthquakeEntity> get recentEarthquakeStream => _watchRecent.call();

  Future<void> getLastEarthquake() async {
    try {
      emit(EarthquakeLoading());
      final last = await _getLast.call();
      emit(EarthquakeLoaded(last));
    } catch (e) {
      emit(EarthquakeFailure(e.toString()));
    }
  }

  Future<void> getRecentEarthquake() async {
    try {
      emit(EarthquakeLoading());
      final recent = await _getRecent.call();
      emit(EarthquakeLoaded(recent));
    } catch (e) {
      emit(EarthquakeFailure(e.toString()));
    }
  }

  void startListening() {
    _lastSub ??= lastEarthquakeStream.listen((e) => emit(EarthquakeLoaded(e)));
    _recentSub ??= recentEarthquakeStream.listen(
      (e) => emit(EarthquakeLoaded(e)),
    );
  }

  @override
  Future<void> close() {
    _lastSub?.cancel();
    _recentSub?.cancel();
    return super.close();
  }
}
