import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../../core/enumerate/enumerate.dart';
import '../../../../utils/helper/helper.dart';
import '../../../models/models.dart';
import 'DAO/dao.dart';

part 'app_databases.g.dart';

@TypeConverters([
  DateTimeConverter,
  PointConverter,
  EarthquakeMmiConverter,
  ListEarthquakeMmiConverter,
  TsunamiConverter,
  WarningZoneConverter,
  AdministrationConverter,
])
@Database(version: 1, entities: [
  EarthquakeModel,
  WeatherModel,
  DailyWeatherModel,
])
abstract class AppDatabase extends FloorDatabase {
  EarthquakeDao get earthquakeDAO;

  WeatherDao get weatherDAO;

  DailyWeatherDao get dailyWeatherDAO;
}
