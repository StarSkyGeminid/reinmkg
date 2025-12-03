import 'dart:async';

import 'package:froom/froom.dart';
import 'package:reinmkg/core/shared/domain/enumerate/wind_direction.dart';
import 'package:reinmkg/features/features.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../utils/helper/converter.dart';

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(
  version: 1,
  entities: [
    WeatherModel,
    DailyWeatherModel,
    EarthquakeModel,
    EarthquakeMmiModel,
    PointModel,
    TsunamiModel,
    WarningZoneModel,
  ],
)
abstract class AppDatabase extends FroomDatabase {
  WeatherDao get weatherDao;
  DailyWeatherDao get dailyWeatherDao;
  EarthquakeDao get earthquakeDAO;
  EarthquakeMmiDao get earthquakeMmiDao;
  PointDao get pointDao;
  TsunamiDao get tsunamiDao;
  WarningZoneDao get warningZoneDao;
}
