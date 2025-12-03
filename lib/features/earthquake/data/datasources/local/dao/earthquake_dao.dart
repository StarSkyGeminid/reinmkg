import 'package:froom/froom.dart';

import '../../../models/earthquake_model.dart';

@dao
abstract class EarthquakeDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEarthquake(EarthquakeModel earthquake);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEarthquakes(List<EarthquakeModel> earthquakes);

  @Query('DELETE FROM earthquake')
  Future<void> deleteAllEarthquake();

  @Query('DELETE FROM earthquake WHERE felt IS NULL')
  Future<void> deleteOneWeekEarthquakes();

  @Query('DELETE FROM earthquake WHERE felt IS NOT NULL')
  Future<void> deleteEarthquakeFelt();

  @Query('SELECT * FROM earthquake LIMIT 1')
  Future<EarthquakeModel?> getRecentEarthquake();

  @Query(
    'SELECT * FROM earthquake WHERE felt IS NOT NULL ORDER BY time DESC LIMIT 1',
  )
  Future<EarthquakeModel?> getLastEarthquakeFelt();

  @Query('SELECT * FROM earthquake WHERE felt IS NOT NULL')
  Future<List<EarthquakeModel>?> getListEarthquakesFelt();

  @Query('SELECT * FROM earthquake')
  Future<List<EarthquakeModel>?> getOneWeekEarthquakes();
}
