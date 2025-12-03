import 'package:froom/froom.dart';

import '../../../models/weather_model.dart';

@dao
abstract class WeatherDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWeathers(List<WeatherModel> listWeathers);

  @Query('DELETE FROM weather')
  Future<void> deleteWeather();

  @Query('SELECT * FROM weather WHERE time > :startTime')
  Future<List<WeatherModel>?> getWeathers(int startTime);

  @Query(
    'SELECT * FROM weather WHERE time > :endTime ORDER BY time ASC LIMIT 1',
  )
  Future<WeatherModel?> getCurrentWeather(int endTime);
}
