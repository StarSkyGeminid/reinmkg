import 'dart:convert';

import 'package:froom/froom.dart';

import '../../../models/administration_model.dart';

class AdministrationConverter
    extends TypeConverter<AdministrationModel?, String?> {
  @override
  AdministrationModel? decode(String? databaseValue) {
    if (databaseValue == null) return null;

    return AdministrationModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String? encode(AdministrationModel? value) {
    if (value == null) return null;

    final model = AdministrationModel.fromEntity(value);

    return jsonEncode(model.toJson());
  }
}
