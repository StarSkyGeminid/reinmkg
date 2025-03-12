// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_databases.dart';

// **************************************************************************
// FloorGenerator
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
class $FloorAppDatabase {
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
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EarthquakeDao? _earthquakeDAOInstance;

  WeatherDao? _weatherDAOInstance;

  DailyWeatherDao? _dailyWeatherDAOInstance;

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
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `earthquake` (`event` TEXT, `time` INTEGER, `point` TEXT, `earthquakeMMI` TEXT, `tsunamiData` TEXT, `latitude` TEXT, `longitude` TEXT, `magnitude` REAL, `depth` REAL, `area` TEXT, `eventid` TEXT, `potential` TEXT, `subject` TEXT, `headline` TEXT, `description` TEXT, `instruction` TEXT, `shakemap` TEXT, `felt` TEXT, `timesent` TEXT, PRIMARY KEY (`eventid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `weather` (`time` INTEGER, `weather` INTEGER, `humidity` REAL, `temperature` REAL, `tcc` REAL, `visibility` REAL, `windDegree` INTEGER, `windDirection` INTEGER, `windSpeed` REAL, PRIMARY KEY (`time`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `dailyWeather` (`time` INTEGER, `weather` INTEGER, `maxTemp` INTEGER, `minTemp` INTEGER, PRIMARY KEY (`time`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EarthquakeDao get earthquakeDAO {
    return _earthquakeDAOInstance ??= _$EarthquakeDao(database, changeListener);
  }

  @override
  WeatherDao get weatherDAO {
    return _weatherDAOInstance ??= _$WeatherDao(database, changeListener);
  }

  @override
  DailyWeatherDao get dailyWeatherDAO {
    return _dailyWeatherDAOInstance ??=
        _$DailyWeatherDao(database, changeListener);
  }
}

class _$EarthquakeDao extends EarthquakeDao {
  _$EarthquakeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _earthquakeModelInsertionAdapter = InsertionAdapter(
            database,
            'earthquake',
            (EarthquakeModel item) => <String, Object?>{
                  'event': item.event,
                  'time': _dateTimeConverter.encode(item.time),
                  'point': _pointConverter.encode(item.point),
                  'earthquakeMMI':
                      _listEarthquakeMmiConverter.encode(item.earthquakeMMI),
                  'tsunamiData': _tsunamiConverter.encode(item.tsunamiData),
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'magnitude': item.magnitude,
                  'depth': item.depth,
                  'area': item.area,
                  'eventid': item.eventid,
                  'potential': item.potential,
                  'subject': item.subject,
                  'headline': item.headline,
                  'description': item.description,
                  'instruction': item.instruction,
                  'shakemap': item.shakemap,
                  'felt': item.felt,
                  'timesent': item.timesent
                });

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
    await _queryAdapter
        .queryNoReturn('DELETE FROM earthquake WEHERE felt IS NULL');
  }

  @override
  Future<void> deleteEarthquakeFelt() async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM earthquake WEHERE felt IS NOT NULL');
  }

  @override
  Future<EarthquakeModel?> getRecentEarthquake() async {
    return _queryAdapter.query('SELECT * FROM earthquake LIMIT 1',
        mapper: (Map<String, Object?> row) => EarthquakeModel(
            event: row['event'] as String?,
            time: _dateTimeConverter.decode(row['time'] as int?),
            point: _pointConverter.decode(row['point'] as String?),
            earthquakeMMI: _listEarthquakeMmiConverter
                .decode(row['earthquakeMMI'] as String?),
            tsunamiData:
                _tsunamiConverter.decode(row['tsunamiData'] as String?),
            latitude: row['latitude'] as String?,
            longitude: row['longitude'] as String?,
            magnitude: row['magnitude'] as double?,
            depth: row['depth'] as double?,
            area: row['area'] as String?,
            eventid: row['eventid'] as String?,
            potential: row['potential'] as String?,
            subject: row['subject'] as String?,
            headline: row['headline'] as String?,
            description: row['description'] as String?,
            instruction: row['instruction'] as String?,
            shakemap: row['shakemap'] as String?,
            felt: row['felt'] as String?,
            timesent: row['timesent'] as String?));
  }

  @override
  Future<EarthquakeModel?> getLastEarthquakeFelt() async {
    return _queryAdapter.query(
        'SELECT * FROM earthquake WHERE felt IS NOT NULL ORDER BY time DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => EarthquakeModel(
            event: row['event'] as String?,
            time: _dateTimeConverter.decode(row['time'] as int?),
            point: _pointConverter.decode(row['point'] as String?),
            earthquakeMMI: _listEarthquakeMmiConverter
                .decode(row['earthquakeMMI'] as String?),
            tsunamiData:
                _tsunamiConverter.decode(row['tsunamiData'] as String?),
            latitude: row['latitude'] as String?,
            longitude: row['longitude'] as String?,
            magnitude: row['magnitude'] as double?,
            depth: row['depth'] as double?,
            area: row['area'] as String?,
            eventid: row['eventid'] as String?,
            potential: row['potential'] as String?,
            subject: row['subject'] as String?,
            headline: row['headline'] as String?,
            description: row['description'] as String?,
            instruction: row['instruction'] as String?,
            shakemap: row['shakemap'] as String?,
            felt: row['felt'] as String?,
            timesent: row['timesent'] as String?));
  }

  @override
  Future<List<EarthquakeModel>?> getListEarthquakesFelt() async {
    return _queryAdapter.queryList(
        'SELECT * FROM earthquake WHERE felt IS NOT NULL',
        mapper: (Map<String, Object?> row) => EarthquakeModel(
            event: row['event'] as String?,
            time: _dateTimeConverter.decode(row['time'] as int?),
            point: _pointConverter.decode(row['point'] as String?),
            earthquakeMMI: _listEarthquakeMmiConverter
                .decode(row['earthquakeMMI'] as String?),
            tsunamiData:
                _tsunamiConverter.decode(row['tsunamiData'] as String?),
            latitude: row['latitude'] as String?,
            longitude: row['longitude'] as String?,
            magnitude: row['magnitude'] as double?,
            depth: row['depth'] as double?,
            area: row['area'] as String?,
            eventid: row['eventid'] as String?,
            potential: row['potential'] as String?,
            subject: row['subject'] as String?,
            headline: row['headline'] as String?,
            description: row['description'] as String?,
            instruction: row['instruction'] as String?,
            shakemap: row['shakemap'] as String?,
            felt: row['felt'] as String?,
            timesent: row['timesent'] as String?));
  }

  @override
  Future<List<EarthquakeModel>?> getOneWeekEarthquakes() async {
    return _queryAdapter.queryList('SELECT * FROM earthquake',
        mapper: (Map<String, Object?> row) => EarthquakeModel(
            event: row['event'] as String?,
            time: _dateTimeConverter.decode(row['time'] as int?),
            point: _pointConverter.decode(row['point'] as String?),
            earthquakeMMI: _listEarthquakeMmiConverter
                .decode(row['earthquakeMMI'] as String?),
            tsunamiData:
                _tsunamiConverter.decode(row['tsunamiData'] as String?),
            latitude: row['latitude'] as String?,
            longitude: row['longitude'] as String?,
            magnitude: row['magnitude'] as double?,
            depth: row['depth'] as double?,
            area: row['area'] as String?,
            eventid: row['eventid'] as String?,
            potential: row['potential'] as String?,
            subject: row['subject'] as String?,
            headline: row['headline'] as String?,
            description: row['description'] as String?,
            instruction: row['instruction'] as String?,
            shakemap: row['shakemap'] as String?,
            felt: row['felt'] as String?,
            timesent: row['timesent'] as String?));
  }

  @override
  Future<void> insertEarthquake(EarthquakeModel earthquake) async {
    await _earthquakeModelInsertionAdapter.insert(
        earthquake, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertEarthquakes(List<EarthquakeModel> earthquakes) async {
    await _earthquakeModelInsertionAdapter.insertList(
        earthquakes, OnConflictStrategy.replace);
  }
}

class _$WeatherDao extends WeatherDao {
  _$WeatherDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
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
                  'windSpeed': item.windSpeed
                });

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
    return _queryAdapter.queryList('SELECT * FROM weather WHERE time > ?1',
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
            windSpeed: row['windSpeed'] as double?),
        arguments: [startTime]);
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
            windSpeed: row['windSpeed'] as double?),
        arguments: [endTime]);
  }

  @override
  Future<void> insertWeathers(List<WeatherModel> listWeathers) async {
    await _weatherModelInsertionAdapter.insertList(
        listWeathers, OnConflictStrategy.replace);
  }
}

class _$DailyWeatherDao extends DailyWeatherDao {
  _$DailyWeatherDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _dailyWeatherModelInsertionAdapter = InsertionAdapter(
            database,
            'dailyWeather',
            (DailyWeatherModel item) => <String, Object?>{
                  'time': _dateTimeConverter.encode(item.time),
                  'weather': item.weather,
                  'maxTemp': item.maxTemp,
                  'minTemp': item.minTemp
                });

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
    return _queryAdapter.queryList('SELECT * FROM dailyWeather WHERE time > ?1',
        mapper: (Map<String, Object?> row) => DailyWeatherModel(
            time: _dateTimeConverter.decode(row['time'] as int?),
            weather: row['weather'] as int?,
            maxTemp: row['maxTemp'] as int?,
            minTemp: row['minTemp'] as int?),
        arguments: [epoch]);
  }

  @override
  Future<void> insertDailyWeathers(
      List<DailyWeatherModel> dailyWeathers) async {
    await _dailyWeatherModelInsertionAdapter.insertList(
        dailyWeathers, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _pointConverter = PointConverter();
final _earthquakeMmiConverter = EarthquakeMmiConverter();
final _listEarthquakeMmiConverter = ListEarthquakeMmiConverter();
final _tsunamiConverter = TsunamiConverter();
final _warningZoneConverter = WarningZoneConverter();
final _administrationConverter = AdministrationConverter();
