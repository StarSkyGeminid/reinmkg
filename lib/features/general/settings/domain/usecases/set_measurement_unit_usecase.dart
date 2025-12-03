import '../repositories/settings_repository.dart';

class SetMeasurementUnitUsecase {
  final SettingsRepository repository;

  SetMeasurementUnitUsecase(this.repository);

  Future<void> call(bool isMetric) async {
    return repository.setMeasurementUnit(isMetric);
  }
}
