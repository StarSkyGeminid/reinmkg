import 'package:equatable/equatable.dart';

class AdministrationEntity extends Equatable {
  final String? adm1;
  final String? adm2;
  final String? adm3;
  final String? adm4;

  const AdministrationEntity({
    this.adm1,
    this.adm2,
    this.adm3,
    this.adm4,
  });

  @override
  List<Object?> get props => [adm1, adm2, adm3, adm4];
}
