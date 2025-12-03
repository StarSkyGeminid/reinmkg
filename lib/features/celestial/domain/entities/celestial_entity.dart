import 'package:equatable/equatable.dart';

import 'celestial_object_entity.dart';

class CelestialEntity extends Equatable {
  final CelestialObjectEntity? sun;
  final CelestialObjectEntity? moon;

  const CelestialEntity({this.sun, this.moon});

  @override
  List<Object?> get props => [sun, moon];
}
