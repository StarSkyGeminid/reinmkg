part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final String language;
  final bool isMetric;

  const SettingsLoaded({this.language = 'en', this.isMetric = true});

  @override
  List<Object> get props => [language, isMetric];
}

class SettingsFailure extends SettingsState {
  final String message;

  const SettingsFailure(this.message);

  @override
  List<Object> get props => [message];
}
