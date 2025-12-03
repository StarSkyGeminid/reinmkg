import '../repositories/settings_repository.dart';

class SetLanguageUsecase {
  final SettingsRepository repository;

  SetLanguageUsecase(this.repository);

  Future<void> call(String languageCode) async {
    return repository.setLanguage(languageCode);
  }
}
