import 'dart:async';
import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:reinmkg/core/enumerate/earthquakes_type.dart';
import 'package:reinmkg/core/error/failure.dart';
import 'package:reinmkg/core/network/network_info.dart';
import 'package:rxdart/subjects.dart';

import '../../../domain/domain.dart';
import '../../data.dart';

class EarthquakeRepositoryImpl implements EarthquakeRepository {
  final RemoteEarthquakeService _remoteEarthquakeService;
  final LocalEarthquakeService _localEarthquakeService;
  final NetworkInfo _networkInfo;

  EarthquakeRepositoryImpl(
    this._remoteEarthquakeService,
    this._localEarthquakeService,
    this._networkInfo,
  ) {
    _initialStream();
  }

  final _selectedEarthquakeStreamController =
      BehaviorSubject<EarthquakeEntity>();

  final _lastEarthquakeFeltStreamController =
      BehaviorSubject<EarthquakeEntity>();

  final _recentEarthquakeStreamController = BehaviorSubject<EarthquakeEntity>();

  @override
  Future<Either<Failure, List<EarthquakeEntity>>>
      getListEarthquakesFelt() async {
    final isConnected = _networkInfo.isConnected;

    final earthquakes = isConnected
        ? await _remoteEarthquakeService.getListEarthquakesFelt()
        : await _localEarthquakeService.getListEarthquakesFelt();

    final data = earthquakes.fold((l) => null, (r) => r);

    if (isConnected && data != null) {
      _localEarthquakeService.replaceLastEarthquakeFelt(data);
    }

    return earthquakes;
  }

  @override
  Future<Either<Failure, EarthquakeEntity>> getLastEarthquakeFelt() async {
    final isConnected = _networkInfo.isConnected;

    final earthquakes = isConnected
        ? await _remoteEarthquakeService.getLastEarthquakeFelt()
        : await _localEarthquakeService.getLastEarthquakeFelt();

    final data = earthquakes.fold((l) => null, (r) => r);

    if (data != null) {
      _lastEarthquakeFeltStreamController.add(data);
    }

    return earthquakes;
  }

  @override
  Future<Either<Failure, List<EarthquakeEntity>>>
      getOneWeekEarthquakes() async {
    final isConnected = _networkInfo.isConnected;

    final earthquakes = isConnected
        ? await _remoteEarthquakeService.getOneWeekEarthquake()
        : await _localEarthquakeService.getOneWeekEarthquakes();

    final data = earthquakes
        .fold((l) => null, (r) => r)
        ?.reversed
        .cast<EarthquakeModel>()
        .toList();

    if (isConnected && data != null) {
      data.add(
        EarthquakeModel.fromEntity(_lastEarthquakeFeltStreamController.value),
      );

      _localEarthquakeService.replaceOneWeekEarthquake(data);
    }

    return earthquakes;
  }

  @override
  Future<Either<Failure, EarthquakeEntity>> getRecentEarthquake() async {
    final isConnected = _networkInfo.isConnected;

    final earthquakes = isConnected
        ? await _remoteEarthquakeService.getRecentEarthquake()
        : await _localEarthquakeService.getRecentEarthquake();

    final data = earthquakes.fold((l) => null, (r) => r);

    if (data != null) {
      _recentEarthquakeStreamController.add(data);
    }

    return earthquakes;
  }

  @override
  Future<Either<Failure, List<EarthquakeEntity>>>
      getEarthquakeHistories() async {
    final List<EarthquakeEntity>? oneWeekEq =
        await getOneWeekEarthquakes().then((value) {
      return value.fold((l) => null, (r) => r);
    });

    final List<EarthquakeEntity>? eqFelt =
        await getListEarthquakesFelt().then((value) {
      return value.fold((l) => null, (r) => r);
    });

    List<EarthquakeEntity>? earthquakeHistories = [];

    if (eqFelt != null) earthquakeHistories.addAll(eqFelt);

    if (oneWeekEq != null) earthquakeHistories.addAll(oneWeekEq.reversed);

    final seen = <String>{};

    final unique = earthquakeHistories
        .where((str) => seen.add(str.eventid ?? ''))
        .toList();

    return earthquakeHistories.isEmpty
        ? Left(NoDataFailure())
        : Right(unique.reversed.toList());
  }

  @override
  Stream<EarthquakeEntity> streamSelectedEarthquake() =>
      _selectedEarthquakeStreamController.asBroadcastStream();

  @override
  void setSelectedEarthquake(EarthquakeEntity earthquakeEntity) {
    _selectedEarthquakeStreamController.add(earthquakeEntity);
  }

  @override
  Stream<EarthquakeEntity> streamLastEarthquakeFelt() =>
      _lastEarthquakeFeltStreamController.asBroadcastStream();

  @override
  Stream<EarthquakeEntity> streamRecentEarthquake() =>
      _recentEarthquakeStreamController.asBroadcastStream();

  Future<void> _initialStream() async {
    await getLastEarthquakeFelt();
    await getRecentEarthquake();

    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_networkInfo.isNotConnected) return;

      _runIsolateStream(
        _remoteEarthquakeService.getLastEarthquakeFelt,
        _lastEarthquakeFeltStreamController,
      );

      _runIsolateStream(
        _remoteEarthquakeService.getRecentEarthquake,
        _recentEarthquakeStreamController,
      );
    });
  }

  void _runIsolateStream(
    dynamic function,
    BehaviorSubject<EarthquakeEntity> stream,
  ) {
    Isolate.run(function).then((value) {
      (value as Either<Failure, EarthquakeEntity>).fold((l) {
        stream.addError(l);
      }, (r) {
        if (stream.value == r) return;

        stream.add(r);
      });
    });
  }

  @override
  Future<Either<Failure, List<EarthquakeEntity>>> getEarthquakesByType(
      EarthquakesType type) {
    return _remoteEarthquakeService.getEarthquakesByType(type);
  }
}
