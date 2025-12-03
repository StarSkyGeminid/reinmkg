import 'package:reinmkg/features/general/settings/domain/entities/settings_entity.dart';
import 'package:reinmkg/core/utils/services/sharedprefs/shared_prefs_mixin.dart';

import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPrefsMixin sharedPrefs;

  SettingsRepositoryImpl(this.sharedPrefs);

  @override
  Future<SettingsEntity> getSettings() {
    String language = sharedPrefs.getData(PrefsKeys.locale) ?? 'en';
    bool isMetric = sharedPrefs.getData(PrefsKeys.measurementUnit) ?? true;

    return Future.value(SettingsEntity(language: language, isMetric: isMetric));
  }

  @override
  Future<void> setLanguage(String languageCode) {
    sharedPrefs.addData(PrefsKeys.locale, languageCode);
    return Future.value();
  }

  @override
  Future<void> setMeasurementUnit(bool isMetric) {
    sharedPrefs.addData(PrefsKeys.measurementUnit, isMetric);
    return Future.value();
  }
}
