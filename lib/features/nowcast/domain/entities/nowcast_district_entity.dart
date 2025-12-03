import 'package:equatable/equatable.dart';

class NowcastDistrictEntity extends Equatable {
  final String? id;
  final String? name;
  final List<String>? subdistricts;

  const NowcastDistrictEntity({this.id, this.name, this.subdistricts});

  @override
  List<Object?> get props => [id, name, subdistricts];
}
