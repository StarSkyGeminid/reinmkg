import 'package:froom/froom.dart';

import '../../../models/warning_zone_model.dart';

@dao
abstract class WarningZoneDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWarningZone(WarningZoneModel warningZone);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWarningZones(List<WarningZoneModel> warningZones);

  @Query('SELECT * FROM warning_zone WHERE eventId = :eventId')
  Future<List<WarningZoneModel>?> getByEventId(String eventId);

  @Query('DELETE FROM warning_zone WHERE eventId = :eventId')
  Future<void> deleteByEventId(String eventId);
}
