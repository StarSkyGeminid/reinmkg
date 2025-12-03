// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FroomGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FroomAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(path, _migrations, _callback);
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WeatherDao? _weatherDaoInstance;

  DailyWeatherDao? _dailyWeatherDaoInstance;

  EarthquakeDao? _earthquakeDAOInstance;

  EarthquakeMmiDao? _earthquakeMmiDaoInstance;

  PointDao? _pointDaoInstance;

  TsunamiDao? _tsunamiDaoInstance;

  WarningZoneDao? _warningZoneDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
          database,
          startVersion,
          endVersion,
          migrations,
        );

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `weather` (`time` INTEGER, `weather` INTEGER, `humidity` REAL, `temperature` REAL, `tcc` REAL, `visibility` REAL, `windDegree` INTEGER, `windDirection` INTEGER, `windSpeed` REAL, PRIMARY KEY (`time`))',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `dailyWeather` (`time` INTEGER, `weather` INTEGER, `maxTemp` INTEGER, `minTemp` INTEGER, PRIMARY KEY (`time`))',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `earthquake` (`id` TEXT, `event` TEXT, `time` INTEGER, `latitude` TEXT, `longitude` TEXT, `magnitude` REAL, `depth` REAL, `area` TEXT, `potential` TEXT, `subject` TEXT, `headline` TEXT, `description` TEXT, `instruction` TEXT, `shakemap` TEXT, `felt` TEXT, `timesent` TEXT, PRIMARY KEY (`id`))',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `earthquakeMmi` (`id` TEXT, `eventId` TEXT, `district` TEXT, `mmiMin` INTEGER, `mmiMax` INTEGER, `latitude` REAL, `longitude` REAL, FOREIGN KEY (`eventId`) REFERENCES `earthquake` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `point` (`id` TEXT, `eventId` TEXT, `latitude` REAL, `longitude` REAL, FOREIGN KEY (`eventId`) REFERENCES `earthquake` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `tsunami` (`id` TEXT, `eventId` TEXT, `shakemap` TEXT, `wzmapUrl` TEXT, `ttmapUrl` TEXT, `ssmmapUrl` TEXT, FOREIGN KEY (`eventId`) REFERENCES `earthquake` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))',
        );
        await database.execute(
          'CREATE TABLE IF NOT EXISTS `warning_zone` (`id` TEXT, `eventId` TEXT, `province` TEXT, `district` TEXT, `level` INTEGER, `dateTime` INTEGER, FOREIGN KEY (`eventId`) REFERENCES `tsunami` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))',
        );

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WeatherDao get weatherDao {
    return _weatherDaoInstance ??= _$WeatherDao(database, changeListener);
  }

  @override
  DailyWeatherDao get dailyWeatherDao {
    return _dailyWeatherDaoInstance ??= _$DailyWeatherDao(
      database,
      changeListener,
    );
  }

  @override
  EarthquakeDao get earthquakeDAO {
    return _earthquakeDAOInstance ??= _$EarthquakeDao(database, changeListener);
  }

  @override
  EarthquakeMmiDao get earthquakeMmiDao {
    return _earthquakeMmiDaoInstance ??= _$EarthquakeMmiDao(
      database,
      changeListener,
    );
  }

  @override
  PointDao get pointDao {
    return _pointDaoInstance ??= _$PointDao(database, changeListener);
  }

  @override
  TsunamiDao get tsunamiDao {
    return _tsunamiDaoInstance ??= _$TsunamiDao(database, changeListener);
  }

  @override
  WarningZoneDao get warningZoneDao {
    return _warningZoneDaoInstance ??= _$WarningZoneDao(
      database,
      changeListener,
    );
  }
}

class _$WeatherDao extends WeatherDao {
  _$WeatherDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _weatherModelInsertionAdapter = InsertionAdapter(
        database,
        'weather',
        (WeatherModel item) => <String, Object?>{
          'time': _dateTimeConverter.encode(item.time),
          'weather': item.weather,
          'humidity': item.humidity,
          'temperature': item.temperature,
          'tcc': item.tcc,
          'visibility': item.visibility,
          'windDegree': item.windDegree,
          'windDirection': item.windDirection?.index,
          'windSpeed': item.windSpeed,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WeatherModel> _weatherModelInsertionAdapter;

  @override
  Future<void> deleteWeather() async {
    await _queryAdapter.queryNoReturn('DELETE FROM weather');
  }

  @override
  Future<List<WeatherModel>?> getWeathers(int startTime) async {
    return _queryAdapter.queryList(
      'SELECT * FROM weather WHERE time > ?1',
      mapper: (Map<String, Object?> row) => WeatherModel(
        time: _dateTimeConverter.decode(row['time'] as int?),
        weather: row['weather'] as int?,
        humidity: row['humidity'] as double?,
        temperature: row['temperature'] as double?,
        tcc: row['tcc'] as double?,
        visibility: row['visibility'] as double?,
        windDegree: row['windDegree'] as int?,
        windDirection: row['windDirection'] == null
            ? null
            : WindDirection.values[row['windDirection'] as int],
        windSpeed: row['windSpeed'] as double?,
      ),
      arguments: [startTime],
    );
  }

  @override
  Future<WeatherModel?> getCurrentWeather(int endTime) async {
    return _queryAdapter.query(
      'SELECT * FROM weather WHERE time > ?1 ORDER BY time ASC LIMIT 1',
      mapper: (Map<String, Object?> row) => WeatherModel(
        time: _dateTimeConverter.decode(row['time'] as int?),
        weather: row['weather'] as int?,
        humidity: row['humidity'] as double?,
        temperature: row['temperature'] as double?,
        tcc: row['tcc'] as double?,
        visibility: row['visibility'] as double?,
        windDegree: row['windDegree'] as int?,
        windDirection: row['windDirection'] == null
            ? null
            : WindDirection.values[row['windDirection'] as int],
        windSpeed: row['windSpeed'] as double?,
      ),
      arguments: [endTime],
    );
  }

  @override
  Future<void> insertWeathers(List<WeatherModel> listWeathers) async {
    await _weatherModelInsertionAdapter.insertList(
      listWeathers,
      OnConflictStrategy.replace,
    );
  }
}

class _$DailyWeatherDao extends DailyWeatherDao {
  _$DailyWeatherDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _dailyWeatherModelInsertionAdapter = InsertionAdapter(
        database,
        'dailyWeather',
        (DailyWeatherModel item) => <String, Object?>{
          'time': _dateTimeConverter.encode(item.time),
          'weather': item.weather,
          'maxTemp': item.maxTemp,
          'minTemp': item.minTemp,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DailyWeatherModel> _dailyWeatherModelInsertionAdapter;

  @override
  Future<void> deleteDailyWeather() async {
    await _queryAdapter.queryNoReturn('DELETE FROM dailyWeather');
  }

  @override
  Future<List<DailyWeatherModel>?> getDailyWeathers(int epoch) async {
    return _queryAdapter.queryList(
      'SELECT * FROM dailyWeather WHERE time > ?1',
      mapper: (Map<String, Object?> row) => DailyWeatherModel(
        time: _dateTimeConverter.decode(row['time'] as int?),
        weather: row['weather'] as int?,
        maxTemp: row['maxTemp'] as int?,
        minTemp: row['minTemp'] as int?,
      ),
      arguments: [epoch],
    );
  }

  @override
  Future<void> insertDailyWeathers(
    List<DailyWeatherModel> dailyWeathers,
  ) async {
    await _dailyWeatherModelInsertionAdapter.insertList(
      dailyWeathers,
      OnConflictStrategy.abort,
    );
  }
}

class _$EarthquakeDao extends EarthquakeDao {
  _$EarthquakeDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _earthquakeModelInsertionAdapter = InsertionAdapter(
        database,
        'earthquake',
        (EarthquakeModel item) => <String, Object?>{
          'id': item.id,
          'event': item.event,
          'time': _dateTimeConverter.encode(item.time),
          'latitude': item.latitude,
          'longitude': item.longitude,
          'magnitude': item.magnitude,
          'depth': item.depth,
          'area': item.area,
          'potential': item.potential,
          'subject': item.subject,
          'headline': item.headline,
          'description': item.description,
          'instruction': item.instruction,
          'shakemap': item.shakemap,
          'felt': item.felt,
          'timesent': item.timesent,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EarthquakeModel> _earthquakeModelInsertionAdapter;

  @override
  Future<void> deleteAllEarthquake() async {
    await _queryAdapter.queryNoReturn('DELETE FROM earthquake');
  }

  @override
  Future<void> deleteOneWeekEarthquakes() async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM earthquake WHERE felt IS NULL',
    );
  }

  @override
  Future<void> deleteEarthquakeFelt() async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM earthquake WHERE felt IS NOT NULL',
    );
  }

  @override
  Future<EarthquakeModel?> getRecentEarthquake() async {
    return _queryAdapter.query(
      'SELECT * FROM earthquake LIMIT 1',
      mapper: (Map<String, Object?> row) => EarthquakeModel(
        id: row['id'] as String?,
        event: row['event'] as String?,
        time: _dateTimeConverter.decode(row['time'] as int?),
        latitude: row['latitude'] as String?,
        longitude: row['longitude'] as String?,
        magnitude: row['magnitude'] as double?,
        depth: row['depth'] as double?,
        area: row['area'] as String?,
        potential: row['potential'] as String?,
        subject: row['subject'] as String?,
        headline: row['headline'] as String?,
        description: row['description'] as String?,
        instruction: row['instruction'] as String?,
        shakemap: row['shakemap'] as String?,
        felt: row['felt'] as String?,
        timesent: row['timesent'] as String?,
      ),
    );
  }

  @override
  Future<EarthquakeModel?> getLastEarthquakeFelt() async {
    return _queryAdapter.query(
      'SELECT * FROM earthquake WHERE felt IS NOT NULL ORDER BY time DESC LIMIT 1',
      mapper: (Map<String, Object?> row) => EarthquakeModel(
        id: row['id'] as String?,
        event: row['event'] as String?,
        time: _dateTimeConverter.decode(row['time'] as int?),
        latitude: row['latitude'] as String?,
        longitude: row['longitude'] as String?,
        magnitude: row['magnitude'] as double?,
        depth: row['depth'] as double?,
        area: row['area'] as String?,
        potential: row['potential'] as String?,
        subject: row['subject'] as String?,
        headline: row['headline'] as String?,
        description: row['description'] as String?,
        instruction: row['instruction'] as String?,
        shakemap: row['shakemap'] as String?,
        felt: row['felt'] as String?,
        timesent: row['timesent'] as String?,
      ),
    );
  }

  @override
  Future<List<EarthquakeModel>?> getListEarthquakesFelt() async {
    return _queryAdapter.queryList(
      'SELECT * FROM earthquake WHERE felt IS NOT NULL',
      mapper: (Map<String, Object?> row) => EarthquakeModel(
        id: row['id'] as String?,
        event: row['event'] as String?,
        time: _dateTimeConverter.decode(row['time'] as int?),
        latitude: row['latitude'] as String?,
        longitude: row['longitude'] as String?,
        magnitude: row['magnitude'] as double?,
        depth: row['depth'] as double?,
        area: row['area'] as String?,
        potential: row['potential'] as String?,
        subject: row['subject'] as String?,
        headline: row['headline'] as String?,
        description: row['description'] as String?,
        instruction: row['instruction'] as String?,
        shakemap: row['shakemap'] as String?,
        felt: row['felt'] as String?,
        timesent: row['timesent'] as String?,
      ),
    );
  }

  @override
  Future<List<EarthquakeModel>?> getOneWeekEarthquakes() async {
    return _queryAdapter.queryList(
      'SELECT * FROM earthquake',
      mapper: (Map<String, Object?> row) => EarthquakeModel(
        id: row['id'] as String?,
        event: row['event'] as String?,
        time: _dateTimeConverter.decode(row['time'] as int?),
        latitude: row['latitude'] as String?,
        longitude: row['longitude'] as String?,
        magnitude: row['magnitude'] as double?,
        depth: row['depth'] as double?,
        area: row['area'] as String?,
        potential: row['potential'] as String?,
        subject: row['subject'] as String?,
        headline: row['headline'] as String?,
        description: row['description'] as String?,
        instruction: row['instruction'] as String?,
        shakemap: row['shakemap'] as String?,
        felt: row['felt'] as String?,
        timesent: row['timesent'] as String?,
      ),
    );
  }

  @override
  Future<void> insertEarthquake(EarthquakeModel earthquake) async {
    await _earthquakeModelInsertionAdapter.insert(
      earthquake,
      OnConflictStrategy.replace,
    );
  }

  @override
  Future<void> insertEarthquakes(List<EarthquakeModel> earthquakes) async {
    await _earthquakeModelInsertionAdapter.insertList(
      earthquakes,
      OnConflictStrategy.replace,
    );
  }
}

class _$EarthquakeMmiDao extends EarthquakeMmiDao {
  _$EarthquakeMmiDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _earthquakeMmiModelInsertionAdapter = InsertionAdapter(
        database,
        'earthquakeMmi',
        (EarthquakeMmiModel item) => <String, Object?>{
          'id': item.id,
          'eventId': item.eventId,
          'district': item.district,
          'mmiMin': item.mmiMin,
          'mmiMax': item.mmiMax,
          'latitude': item.latitude,
          'longitude': item.longitude,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EarthquakeMmiModel>
  _earthquakeMmiModelInsertionAdapter;

  @override
  Future<List<EarthquakeMmiModel>?> getByEventId(String eventId) async {
    return _queryAdapter.queryList(
      'SELECT * FROM earthquakeMmi WHERE eventId = ?1',
      mapper: (Map<String, Object?> row) => EarthquakeMmiModel(
        id: row['id'] as String?,
        eventId: row['eventId'] as String?,
        district: row['district'] as String?,
        mmiMin: row['mmiMin'] as int?,
        mmiMax: row['mmiMax'] as int?,
        latitude: row['latitude'] as double?,
        longitude: row['longitude'] as double?,
      ),
      arguments: [eventId],
    );
  }

  @override
  Future<EarthquakeMmiModel?> getById(String id) async {
    return _queryAdapter.query(
      'SELECT * FROM earthquakeMmi WHERE id = ?1 LIMIT 1',
      mapper: (Map<String, Object?> row) => EarthquakeMmiModel(
        id: row['id'] as String?,
        eventId: row['eventId'] as String?,
        district: row['district'] as String?,
        mmiMin: row['mmiMin'] as int?,
        mmiMax: row['mmiMax'] as int?,
        latitude: row['latitude'] as double?,
        longitude: row['longitude'] as double?,
      ),
      arguments: [id],
    );
  }

  @override
  Future<void> deleteByEventId(String eventId) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM earthquakeMmi WHERE eventId = ?1',
      arguments: [eventId],
    );
  }

  @override
  Future<void> insertEarthquakeMmi(EarthquakeMmiModel earthquakeMmi) async {
    await _earthquakeMmiModelInsertionAdapter.insert(
      earthquakeMmi,
      OnConflictStrategy.replace,
    );
  }

  @override
  Future<void> insertEarthquakeMmis(
    List<EarthquakeMmiModel> earthquakeMmis,
  ) async {
    await _earthquakeMmiModelInsertionAdapter.insertList(
      earthquakeMmis,
      OnConflictStrategy.replace,
    );
  }
}

class _$PointDao extends PointDao {
  _$PointDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _pointModelInsertionAdapter = InsertionAdapter(
        database,
        'point',
        (PointModel item) => <String, Object?>{
          'id': item.id,
          'eventId': item.eventId,
          'latitude': item.latitude,
          'longitude': item.longitude,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PointModel> _pointModelInsertionAdapter;

  @override
  Future<List<PointModel>?> getPointsByEventId(String eventId) async {
    return _queryAdapter.queryList(
      'SELECT * FROM point WHERE eventId = ?1',
      mapper: (Map<String, Object?> row) => PointModel(
        id: row['id'] as String?,
        eventId: row['eventId'] as String?,
        latitude: row['latitude'] as double?,
        longitude: row['longitude'] as double?,
      ),
      arguments: [eventId],
    );
  }

  @override
  Future<PointModel?> getPointById(String id) async {
    return _queryAdapter.query(
      'SELECT * FROM point WHERE id = ?1 LIMIT 1',
      mapper: (Map<String, Object?> row) => PointModel(
        id: row['id'] as String?,
        eventId: row['eventId'] as String?,
        latitude: row['latitude'] as double?,
        longitude: row['longitude'] as double?,
      ),
      arguments: [id],
    );
  }

  @override
  Future<void> deleteByEventId(String eventId) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM point WHERE eventId = ?1',
      arguments: [eventId],
    );
  }

  @override
  Future<void> insertPoint(PointModel point) async {
    await _pointModelInsertionAdapter.insert(point, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertPoints(List<PointModel> points) async {
    await _pointModelInsertionAdapter.insertList(
      points,
      OnConflictStrategy.replace,
    );
  }
}

class _$TsunamiDao extends TsunamiDao {
  _$TsunamiDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _tsunamiModelInsertionAdapter = InsertionAdapter(
        database,
        'tsunami',
        (TsunamiModel item) => <String, Object?>{
          'id': item.id,
          'eventId': item.eventId,
          'shakemap': item.shakemap,
          'wzmapUrl': item.wzmapUrl,
          'ttmapUrl': item.ttmapUrl,
          'ssmmapUrl': item.sshmmapUrl,
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TsunamiModel> _tsunamiModelInsertionAdapter;

  @override
  Future<TsunamiModel?> getByEventId(String eventId) async {
    return _queryAdapter.query(
      'SELECT * FROM tsunami WHERE eventId = ?1 LIMIT 1',
      mapper: (Map<String, Object?> row) => TsunamiModel(
        id: row['id'] as String?,
        eventId: row['eventId'] as String?,
        shakemap: row['shakemap'] as String?,
        wzmapUrl: row['wzmapUrl'] as String?,
        ttmapUrl: row['ttmapUrl'] as String?,
        sshmmapUrl: row['ssmmapUrl'] as String?,
      ),
      arguments: [eventId],
    );
  }

  @override
  Future<void> deleteByEventId(String eventId) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM tsunami WHERE eventId = ?1',
      arguments: [eventId],
    );
  }

  @override
  Future<void> insertTsunami(TsunamiModel tsunami) async {
    await _tsunamiModelInsertionAdapter.insert(
      tsunami,
      OnConflictStrategy.replace,
    );
  }

  @override
  Future<void> insertTsunamis(List<TsunamiModel> tsunamis) async {
    await _tsunamiModelInsertionAdapter.insertList(
      tsunamis,
      OnConflictStrategy.replace,
    );
  }
}

class _$WarningZoneDao extends WarningZoneDao {
  _$WarningZoneDao(this.database, this.changeListener)
    : _queryAdapter = QueryAdapter(database),
      _warningZoneModelInsertionAdapter = InsertionAdapter(
        database,
        'warning_zone',
        (WarningZoneModel item) => <String, Object?>{
          'id': item.id,
          'eventId': item.eventId,
          'province': item.province,
          'district': item.district,
          'level': item.level?.index,
          'dateTime': _dateTimeConverter.encode(item.dateTime),
        },
      );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WarningZoneModel> _warningZoneModelInsertionAdapter;

  @override
  Future<List<WarningZoneModel>?> getByEventId(String eventId) async {
    return _queryAdapter.queryList(
      'SELECT * FROM warning_zone WHERE eventId = ?1',
      mapper: (Map<String, Object?> row) => WarningZoneModel(
        id: row['id'] as String?,
        eventId: row['eventId'] as String?,
        district: row['district'] as String?,
        dateTime: _dateTimeConverter.decode(row['dateTime'] as int?),
        level: row['level'] == null
            ? null
            : WarningZoneLevel.values[row['level'] as int],
        province: row['province'] as String?,
      ),
      arguments: [eventId],
    );
  }

  @override
  Future<void> deleteByEventId(String eventId) async {
    await _queryAdapter.queryNoReturn(
      'DELETE FROM warning_zone WHERE eventId = ?1',
      arguments: [eventId],
    );
  }

  @override
  Future<void> insertWarningZone(WarningZoneModel warningZone) async {
    await _warningZoneModelInsertionAdapter.insert(
      warningZone,
      OnConflictStrategy.replace,
    );
  }

  @override
  Future<void> insertWarningZones(List<WarningZoneModel> warningZones) async {
    await _warningZoneModelInsertionAdapter.insertList(
      warningZones,
      OnConflictStrategy.replace,
    );
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
