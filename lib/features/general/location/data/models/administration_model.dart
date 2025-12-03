import 'package:froom/froom.dart';

import '../../domain/entities/administration_entity.dart';
import '../datasources/local/converters/administration_converter.dart';

@TypeConverters([AdministrationConverter])
class AdministrationModel extends AdministrationEntity {
  const AdministrationModel({super.adm1, super.adm2, super.adm3, super.adm4});

  factory AdministrationModel.fromEntity(AdministrationEntity entity) {
    return AdministrationModel(
      adm1: entity.adm1,
      adm2: entity.adm2,
      adm3: entity.adm3,
      adm4: entity.adm4,
    );
  }

  factory AdministrationModel.fromJson(Map<String, dynamic> json) {
    return AdministrationModel(
      adm1: json['adm1'] as String?,
      adm2: json['adm2'] as String?,
      adm3: json['adm3'] as String?,
      adm4: json['adm4'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adm1': adm1,
      'adm2': adm2,
      'adm3': adm3,
      'adm4': adm4,
    };
  }

}
