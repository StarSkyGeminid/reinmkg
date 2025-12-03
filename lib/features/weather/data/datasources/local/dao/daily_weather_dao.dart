import 'package:froom/froom.dart';

import '../../../models/daily_weather_model.dart';

@dao
abstract class DailyWeatherDao {
  @Insert()
  Future<void> insertDailyWeathers(List<DailyWeatherModel> dailyWeathers);

  @Query('DELETE FROM dailyWeather')
  Future<void> deleteDailyWeather();

  @Query('SELECT * FROM dailyWeather WHERE time > :epoch')
  Future<List<DailyWeatherModel>?> getDailyWeathers(int epoch);
}
