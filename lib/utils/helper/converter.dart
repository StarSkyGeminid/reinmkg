import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:reinmkg/domain/domain.dart';

import '../../data/models/models.dart';

class DateTimeConverter extends TypeConverter<DateTime?, int?> {
  @override
  DateTime? decode(int? databaseValue) {
    if (databaseValue == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int? encode(DateTime? value) {
    if (value == null) return null;

    return value.millisecondsSinceEpoch;
  }
}

class PointConverter extends TypeConverter<PointEntity?, String?> {
  @override
  PointEntity? decode(String? databaseValue) {
    if (databaseValue == null) return null;

    return PointModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String? encode(PointEntity? value) {
    if (value == null) return null;

    final model = PointModel.fromEntity(value);

    return jsonEncode(model.toJson());
  }
}

class EarthquakeMmiConverter
    extends TypeConverter<EarthquakeMmiEntity?, String?> {
  @override
  EarthquakeMmiEntity? decode(String? databaseValue) {
    if (databaseValue == null) return null;

    return EarthquakeMmiModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String? encode(EarthquakeMmiEntity? value) {
    if (value == null) return null;

    final model = EarthquakeMmiModel.fromEntity(value);

    return jsonEncode(model.toJson());
  }
}

class ListEarthquakeMmiConverter
    extends TypeConverter<List<EarthquakeMmiEntity>?, String?> {
  @override
  List<EarthquakeMmiModel>? decode(String? databaseValue) {
    if (databaseValue == null) return null;

    final data = jsonDecode(databaseValue);

    final listMmi = data.map((value) {
      return EarthquakeMmiModel.fromJson(value);
    }).toList();

    return List<EarthquakeMmiModel>.from(listMmi);
  }

  @override
  String? encode(List<EarthquakeMmiEntity>? value) {
    if (value == null) return null;

    final model = value.map((e) {
      return EarthquakeMmiModel.fromEntity(e).toJson();
    }).toList();

    return jsonEncode(model);
  }
}

class TsunamiConverter extends TypeConverter<TsunamiEntity?, String?> {
  @override
  TsunamiEntity? decode(String? databaseValue) {
    if (databaseValue == null) return null;

    final data = jsonDecode(databaseValue);

    return TsunamiModel.fromJson(data);
  }

  @override
  String? encode(TsunamiEntity? value) {
    if (value == null) return null;

    final model = TsunamiModel.fromEntity(value).toJson();

    return model.toString();
  }
}

class WarningZoneConverter
    extends TypeConverter<List<WarningZoneEntity>?, String?> {
  @override
  List<WarningZoneEntity>? decode(String? databaseValue) {
    if (databaseValue == null) return null;

    final data = jsonDecode(databaseValue);

    return data.map((value) {
      WarningZoneModel.fromJson(value);
    });
  }

  @override
  String? encode(List<WarningZoneEntity>? value) {
    if (value == null) return null;

    final model = value.map((e) {
      return WarningZoneModel.fromEntity(e).toJson();
    });

    return model.toString();
  }
}

class AdministrationConverter
    extends TypeConverter<AdministrationEntity?, String?> {
  @override
  AdministrationEntity? decode(String? databaseValue) {
    if (databaseValue == null) return null;

    return AdministrationModel.fromJson(jsonDecode(databaseValue));
  }

  @override
  String? encode(AdministrationEntity? value) {
    if (value == null) return null;

    final model = AdministrationModel.fromEntity(value);

    return jsonEncode(model.toJson());
  }
}
