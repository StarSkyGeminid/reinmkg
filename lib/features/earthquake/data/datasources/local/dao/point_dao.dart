import 'package:froom/froom.dart';

import '../../../models/point_model.dart';

@dao
abstract class PointDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPoint(PointModel point);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPoints(List<PointModel> points);

  @Query('SELECT * FROM point WHERE eventId = :eventId')
  Future<List<PointModel>?> getPointsByEventId(String eventId);

  @Query('SELECT * FROM point WHERE id = :id LIMIT 1')
  Future<PointModel?> getPointById(String id);

  @Query('DELETE FROM point WHERE eventId = :eventId')
  Future<void> deleteByEventId(String eventId);
}
