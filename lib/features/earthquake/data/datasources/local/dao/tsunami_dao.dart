import 'package:froom/froom.dart';

import '../../../models/tsunami_model.dart';

@dao
abstract class TsunamiDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTsunami(TsunamiModel tsunami);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTsunamis(List<TsunamiModel> tsunamis);

  @Query('SELECT * FROM tsunami WHERE eventId = :eventId LIMIT 1')
  Future<TsunamiModel?> getByEventId(String eventId);

  @Query('DELETE FROM tsunami WHERE eventId = :eventId')
  Future<void> deleteByEventId(String eventId);
}
