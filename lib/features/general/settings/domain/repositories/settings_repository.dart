import '../entities/settings_entity.dart';

abstract class SettingsRepository {
  Future<SettingsEntity> getSettings();

  Future<void> setLanguage(String languageCode);

  Future<void> setMeasurementUnit(bool isMetric);
}
