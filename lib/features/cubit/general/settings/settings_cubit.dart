import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enumerate/bloc_state.dart';
import '../../../../core/enumerate/measurement_unit.dart';
import '../../../../utils/services/shared_prefs/prefs.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> with MainPrefsMixin {
  SettingsCubit() : super(const SettingsState.initial());

  void initial() {
    emit(state.copyWith(
      status: BlocState.success,
      language: getData(MainPrefsKeys.locale) ?? 'en',
      measurementUnit: getMeasurementUnit(),
    ));
  }

  void updateLanguage(String language) {
    addData(MainPrefsKeys.locale, language);
    emit(
      state.copyWith(
        status: BlocState.success,
        language: language,
      ),
    );
  }

  void updateUnit(MeasurementUnit unit) {
    addData(MainPrefsKeys.measurementUnit, unit.name);
    emit(
      state.copyWith(
        status: BlocState.success,
        measurementUnit: unit,
      ),
    );
  }

  MeasurementUnit getMeasurementUnit() {
    final unit =
        (getData(MainPrefsKeys.measurementUnit) ?? MeasurementUnit.metric.name);

    final measurementUnit = MeasurementUnit.values.singleWhere(
      (element) => element.name == unit,
      orElse: () => MeasurementUnit.metric,
    );

    return measurementUnit;
  }
}
