import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/settings_entity.dart';
import '../../domain/usecases/usecases.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetSettingsUsecase getSettingsUsecase;
  final SetLanguageUsecase setLanguageUsecase;
  final SetMeasurementUnitUsecase setMeasurementUnitUsecase;

  SettingsEntity? settings;

  SettingsCubit(
    this.getSettingsUsecase,
    this.setLanguageUsecase,
    this.setMeasurementUnitUsecase,
  ) : super(SettingsInitial()) {
    initial();
  }

  Future<void> initial() async {
    emit(SettingsLoading());

    try {
      settings = await getSettingsUsecase();

      emit(
        SettingsLoaded(
          language: settings!.language,
          isMetric: settings!.isMetric,
        ),
      );
    } catch (e) {
      emit(SettingsFailure(e.toString()));
      return;
    }
  }

  void updateLanguage(String language) {
    try {
      setLanguageUsecase(language);
      emit(SettingsLoaded(language: language, isMetric: settings!.isMetric));
    } catch (e) {
      emit(SettingsFailure(e.toString()));
      return;
    }
  }

  void updateUnit(bool isMetric) {
    try {
      setMeasurementUnitUsecase(isMetric);
      emit(SettingsLoaded(language: settings!.language, isMetric: isMetric));
    } catch (e) {
      emit(SettingsFailure(e.toString()));
      return;
    }
  }
}
