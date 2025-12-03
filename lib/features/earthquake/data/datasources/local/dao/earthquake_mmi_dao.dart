import 'package:froom/froom.dart';

import '../../../models/earthquake_mmi_model.dart';

@dao
abstract class EarthquakeMmiDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEarthquakeMmi(EarthquakeMmiModel earthquakeMmi);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertEarthquakeMmis(List<EarthquakeMmiModel> earthquakeMmis);

  @Query('SELECT * FROM earthquakeMmi WHERE eventId = :eventId')
  Future<List<EarthquakeMmiModel>?> getByEventId(String eventId);

  @Query('SELECT * FROM earthquakeMmi WHERE id = :id LIMIT 1')
  Future<EarthquakeMmiModel?> getById(String id);

  @Query('DELETE FROM earthquakeMmi WHERE eventId = :eventId')
  Future<void> deleteByEventId(String eventId);
}
