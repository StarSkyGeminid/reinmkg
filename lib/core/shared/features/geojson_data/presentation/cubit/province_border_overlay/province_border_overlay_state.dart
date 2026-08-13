part of 'province_border_overlay_cubit.dart';

class ProvinceBorderOverlayState extends Equatable {
  final Map<String, dynamic>? border;

  const ProvinceBorderOverlayState({this.border});

  @override
  List<Object?> get props => [border];
}
