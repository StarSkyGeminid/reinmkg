import '../entities/satelite_entity.dart';

abstract class SateliteRepository {
  Future<List<SateliteEntity>> getSateliteImages();
}