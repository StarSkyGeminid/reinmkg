import 'package:reinmkg/core/data/local/app_database.dart';

import '../../models/models.dart';

abstract class LocalEarthquakeService {
  Future<EarthquakeModel> getLastEarthquakeFelt();

  Future<EarthquakeModel> getRecentEarthquake();

  Future<List<EarthquakeModel>> getOneWeekEarthquakes();

  Future<List<EarthquakeModel>> getListEarthquakesFelt();

  Future<void> replaceOneWeekEarthquake(List<EarthquakeModel> earthquakes);

  Future<void> replaceLastEarthquakeFelt(List<EarthquakeModel> earthquakes);
}

class LocalEarthquakeServiceImpl implements LocalEarthquakeService {
  final AppDatabase _appDatabase;

  LocalEarthquakeServiceImpl(this._appDatabase);

  @override
  Future<EarthquakeModel> getLastEarthquakeFelt() async {
    try {
      final earthquake = await _appDatabase.earthquakeDAO
          .getLastEarthquakeFelt();

      if (earthquake == null) throw Exception('No earthquake found');

      return earthquake;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<EarthquakeModel> getRecentEarthquake() async {
    try {
      final earthquake = await _appDatabase.earthquakeDAO.getRecentEarthquake();

      if (earthquake == null) throw Exception('No earthquake found');

      return earthquake;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<EarthquakeModel>> getListEarthquakesFelt() async {
    try {
      final earthquakes = await _appDatabase.earthquakeDAO
          .getListEarthquakesFelt();

      if (earthquakes == null) throw Exception('No earthquakes found');

      return earthquakes;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<EarthquakeModel>> getOneWeekEarthquakes() async {
    try {
      final earthquakes = await _appDatabase.earthquakeDAO
          .getOneWeekEarthquakes();

      if (earthquakes == null) throw Exception('No earthquakes found');

      return earthquakes;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> replaceLastEarthquakeFelt(
    List<EarthquakeModel> earthquakes,
  ) async {
    await _appDatabase.earthquakeDAO.deleteEarthquakeFelt();

    try {
      await (_appDatabase.earthquakeDAO as dynamic).insertEarthquakesFelt(
        earthquakes,
      );
    } catch (e) {
      await _appDatabase.earthquakeDAO.insertEarthquakes(earthquakes);
    }

    try {
      for (final eq in earthquakes) {
        final eventId = eq.id;

        if (eventId == null) continue;

        if (eq.point != null) {
          final point = PointModel(
            id: '$eventId-point',
            eventId: eventId,
            latitude: eq.point?.latitude,
            longitude: eq.point?.longitude,
          );
          await _appDatabase.pointDao.insertPoint(point);
        }

        if (eq.earthquakeMMI != null && eq.earthquakeMMI!.isNotEmpty) {
          try {
            final mmiModels = eq.earthquakeMMI!
                .map(
                  (e) => e is EarthquakeMmiModel
                      ? e
                      : EarthquakeMmiModel.fromEntity(e),
                )
                .toList();

            await _appDatabase.earthquakeMmiDao.insertEarthquakeMmis(mmiModels);
          } catch (_) {}
        }

        if (eq.tsunamiData != null) {
          final ts = eq.tsunamiData!;
          final tsunamiToInsert = TsunamiModel(
            id: ts.id,
            eventId: eventId,
            shakemap: ts.shakemap,
            wzmapUrl: ts.wzmapUrl,
            ttmapUrl: ts.ttmapUrl,
            sshmmapUrl: ts.sshmmapUrl,
            warningZone: ts.warningZone
                ?.map(
                  (w) => WarningZoneModel(
                    id: w.id,
                    eventId: eventId,
                    district: w.district,
                    dateTime: w.dateTime,
                    level: w.level,
                    province: w.province,
                  ),
                )
                .toList(),
          );

          await _appDatabase.tsunamiDao.insertTsunami(tsunamiToInsert);

          final warningModels = ts.warningZone
              ?.map(
                (w) =>
                    w is WarningZoneModel ? w : WarningZoneModel.fromEntity(w),
              )
              .map(
                (w) => WarningZoneModel(
                  id: w.id,
                  eventId: eventId,
                  district: w.district,
                  dateTime: w.dateTime,
                  level: w.level,
                  province: w.province,
                ),
              )
              .toList();

          if (warningModels != null && warningModels.isNotEmpty) {
            try {
              await _appDatabase.warningZoneDao.insertWarningZones(
                warningModels,
              );
            } catch (_) {}
          }
        }
      }
    } catch (_) {}
  }

  @override
  Future<void> replaceOneWeekEarthquake(
    List<EarthquakeModel> earthquakes,
  ) async {
    await _appDatabase.earthquakeDAO.deleteOneWeekEarthquakes();

    try {
      await (_appDatabase.earthquakeDAO as dynamic).insertOneWeekEarthquakes(
        earthquakes,
      );
    } catch (e) {
      await _appDatabase.earthquakeDAO.insertEarthquakes(earthquakes);
    }

    try {
      for (final eq in earthquakes) {
        final eventId = eq.id;

        if (eventId == null) continue;

        if (eq.point != null) {
          final point = PointModel(
            id: '$eventId-point',
            eventId: eventId,
            latitude: eq.point?.latitude,
            longitude: eq.point?.longitude,
          );
          await _appDatabase.pointDao.insertPoint(point);
        }

        if (eq.earthquakeMMI != null && eq.earthquakeMMI!.isNotEmpty) {
          try {
            final mmiModels = eq.earthquakeMMI!
                .map(
                  (e) => e is EarthquakeMmiModel
                      ? e
                      : EarthquakeMmiModel.fromEntity(e),
                )
                .toList();

            await _appDatabase.earthquakeMmiDao.insertEarthquakeMmis(mmiModels);
          } catch (_) {}
        }

        if (eq.tsunamiData != null) {
          final ts = eq.tsunamiData!;
          final tsunamiToInsert = TsunamiModel(
            id: ts.id,
            eventId: eventId,
            shakemap: ts.shakemap,
            wzmapUrl: ts.wzmapUrl,
            ttmapUrl: ts.ttmapUrl,
            sshmmapUrl: ts.sshmmapUrl,
            warningZone: ts.warningZone
                ?.map(
                  (w) => WarningZoneModel(
                    id: w.id,
                    eventId: eventId,
                    district: w.district,
                    dateTime: w.dateTime,
                    level: w.level,
                    province: w.province,
                  ),
                )
                .toList(),
          );

          await _appDatabase.tsunamiDao.insertTsunami(tsunamiToInsert);

          final warningModels = ts.warningZone
              ?.map(
                (w) =>
                    w is WarningZoneModel ? w : WarningZoneModel.fromEntity(w),
              )
              .map(
                (w) => WarningZoneModel(
                  id: w.id,
                  eventId: eventId,
                  district: w.district,
                  dateTime: w.dateTime,
                  level: w.level,
                  province: w.province,
                ),
              )
              .toList();

          if (warningModels != null && warningModels.isNotEmpty) {
            try {
              await _appDatabase.warningZoneDao.insertWarningZones(
                warningModels,
              );
            } catch (_) {}
          }
        }
      }
    } catch (_) {}
  }
}
