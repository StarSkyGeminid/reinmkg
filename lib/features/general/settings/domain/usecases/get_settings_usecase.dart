
import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class GetSettingsUsecase {
  final SettingsRepository repository;

  GetSettingsUsecase(this.repository);

  Future<SettingsEntity> call() async {
    return repository.getSettings();
  }
}
