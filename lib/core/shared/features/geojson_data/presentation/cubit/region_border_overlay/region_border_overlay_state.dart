part of 'region_border_overlay_cubit.dart';

class RegionBorderOverlayState extends Equatable {
  final Map<String, dynamic>? border;

  const RegionBorderOverlayState({this.border});

  @override
  List<Object?> get props => [border];
}
