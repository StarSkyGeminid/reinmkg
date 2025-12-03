import '../../domain/entities/satelite_entity.dart';
import '../../domain/repositories/satelite_repository.dart';
import '../datasources/remote/remote_satelite_service.dart';

class SateliteRepositoryImpl implements SateliteRepository {
  final RemoteSateliteService _remoteSateliteService;

  SateliteRepositoryImpl(this._remoteSateliteService);

  @override
  Future<List<SateliteEntity>> getSateliteImages() {
    return _remoteSateliteService.getSateliteImages();
  }
}
