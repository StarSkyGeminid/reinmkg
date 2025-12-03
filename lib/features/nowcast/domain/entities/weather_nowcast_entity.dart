import 'package:equatable/equatable.dart';

import 'nowcast_district_entity.dart';

class WeatherNowcastEntity extends Equatable {
  final String? id;
  final DateTime? dateSent;
  final DateTime? dateExpired;
  final String? province;
  final String? headline;
  final String? description;
  final String? imageUrl;
  final String? textUrl;
  final List<NowcastDistrictEntity>? affectedDistricts;
  final List<NowcastDistrictEntity>? spreadDistricts;
  final String? event;
  final String? severity;
  final String? category;
  final DateTime? validFrom;
  final DateTime? validUntil;
  final String? source;
  final List<String>? tags;

  const WeatherNowcastEntity({
    this.id,
    this.dateSent,
    this.dateExpired,
    this.province,
    this.headline,
    this.description,
    this.imageUrl,
    this.textUrl,
    this.affectedDistricts,
    this.spreadDistricts,
    this.event,
    this.severity,
    this.category,
    this.validFrom,
    this.validUntil,
    this.source,
    this.tags,
  });

  @override
  List<Object?> get props => [
    id,
    dateSent,
    dateExpired,
    province,
    headline,
    description,
    imageUrl,
    textUrl,
    affectedDistricts,
    spreadDistricts,
    event,
    severity,
    category,
    validFrom,
    validUntil,
    source,
    tags,
  ];
}
