import '../../domain/entities/nowcast_district_entity.dart';
import '../../domain/entities/weather_nowcast_entity.dart';
import 'nowcast_parsers.dart';
import 'nowcast_district_model.dart';

class WeatherNowcastModel extends WeatherNowcastEntity {
  const WeatherNowcastModel({
    super.id,
    super.dateSent,
    super.dateExpired,
    super.province,
    super.headline,
    super.description,
    super.imageUrl,
    super.textUrl,
    super.affectedDistricts,
    super.spreadDistricts,
    super.event,
    super.severity,
    super.category,
    super.validFrom,
    super.validUntil,
    super.source,
    super.tags,
  });

  factory WeatherNowcastModel.fromJson(Map<String, dynamic> json) {
    final timezone = (json['timezone'] as String?)?.split(' ').last ?? '';
    final expiredRaw = (json['expired'] as String?)?.replaceFirst(' ', 'T');
    final dateSentRaw =
        (json['Date_sent'] as String?)?.replaceFirst(' ', 'T') ??
        (json['date_sent'] as String?)?.replaceFirst(' ', 'T');

    String? parseString(dynamic v) => v?.toString();

    final sourceText =
        (json['description'] as String?) ??
        (json['headline'] as String?) ??
        (json['text'] as String?) ??
        '';

    final affected =
        (json['affectedDistricts'] as List<dynamic>?)
            ?.map((e) => NowcastDistrictModel.fromJson(e))
            .toList() ??
        parseDistrictsFromText(sourceText);
    final spread =
        (json['spreadDistricts'] as List<dynamic>?)
            ?.map((e) => NowcastDistrictModel.fromJson(e))
            .toList() ??
        parseDistrictsFromText(sourceText);

    final tags = parseStringList(
      json['tags'] ?? json['labels'] ?? json['kategori'],
    );

    final range = extractValidityRange(sourceText);

    final validFrom = range['from'];
    final validUntil = range['to'];

    return WeatherNowcastModel(
      id: json['ID_Kode'] as String? ?? json['id'] as String?,
      dateSent: tryParseDateWithTimezone(dateSentRaw, timezone)?.toLocal(),
      dateExpired: tryParseDateWithTimezone(expiredRaw, timezone)?.toLocal(),
      province: extractProvince(
        json['headline'] as String?,
        json['description'] as String?,
      ),
      headline: json['headline'] as String?,
      description: json['description'] as String?,
      imageUrl: json['infografis'] as String? ?? json['image'] as String?,
      textUrl: json['text'] as String?,
      affectedDistricts: affected?.cast<NowcastDistrictEntity>(),
      spreadDistricts: spread?.cast<NowcastDistrictEntity>(),
      event: parseString(json['event'] ?? json['jenis'] ?? json['type']),
      severity: parseString(json['severity'] ?? json['level']),
      category: parseString(
        json['category'] ?? json['kategori'] ?? json['type'],
      ),
      validFrom: validFrom?.toLocal(),
      validUntil: validUntil?.toLocal(),
      source: parseString(json['source'] ?? json['sumber']),
      tags: tags,
    );
  }
}
