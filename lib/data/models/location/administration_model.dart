import '../../../domain/entities/location/administration_entity.dart';

class AdministrationModel extends AdministrationEntity {
  const AdministrationModel({
    super.adm1,
    super.adm2,
    super.adm3,
    super.adm4,
  });

  factory AdministrationModel.fromJson(Map<String, dynamic> json) {
    return AdministrationModel(
      adm1: json['adm1'],
      adm2: json['adm2'],
      adm3: json['adm3'],
      adm4: json['adm4'],
    );
  }

  factory AdministrationModel.fromEntity(AdministrationEntity entity) {
    return AdministrationModel(
      adm1: entity.adm1,
      adm2: entity.adm2,
      adm3: entity.adm3,
      adm4: entity.adm4,
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

  AdministrationModel copyWith({
    String? adm1,
    String? adm2,
    String? adm3,
    String? adm4,
  }) {
    return AdministrationModel(
      adm1: adm1 ?? this.adm1,
      adm2: adm2 ?? this.adm2,
      adm3: adm3 ?? this.adm3,
      adm4: adm4 ?? this.adm4,
    );
  }
}
