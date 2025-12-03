import 'package:equatable/equatable.dart';

class SettingsEntity extends Equatable {
  final String language;
  final bool isMetric;

  const SettingsEntity({required this.language, required this.isMetric});

  @override
  List<Object?> get props => [language, isMetric];
}
