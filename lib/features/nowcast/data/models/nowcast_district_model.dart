import '../../domain/entities/nowcast_district_entity.dart';
import 'nowcast_parsers.dart';

class NowcastDistrictModel extends NowcastDistrictEntity {
  const NowcastDistrictModel({super.id, super.name, super.subdistricts});

  factory NowcastDistrictModel.fromJson(dynamic json) {
    if (json == null) return const NowcastDistrictModel();
    if (json is String) {
      return NowcastDistrictModel(name: cleanDistrictName(json));
    }
    if (json is Map) {
      return NowcastDistrictModel(
        id: json['id'] as String?,
        name: json['name'] is String
            ? cleanDistrictName(json['name'] as String)
            : (json['nama'] is String
                  ? cleanDistrictName(json['nama'] as String)
                  : null),
        subdistricts: parseSubdistrictList(
          json['subdistricts'] ?? json['kecamatan'] ?? json['sub'],
        ),
      );
    }
    return NowcastDistrictModel(name: cleanDistrictName(json.toString()));
  }
}

List<NowcastDistrictModel>? parseDistrictsFromText(String? text) {
  if (text == null || text.trim().isEmpty) return null;
  final results = <NowcastDistrictModel>[];

  final regStart = RegExp(
    r"\b(?:Kabupaten|Kab\.?|Kota)\s+",
    caseSensitive: false,
  );
  final starts = regStart.allMatches(text).map((m) => m.start).toList();
  if (starts.isNotEmpty) {
    for (var i = 0; i < starts.length; i++) {
      final start = starts[i];
      final end = (i + 1) < starts.length ? starts[i + 1] : text.length;
      final segment = text.substring(start, end);
      final nameMatch = RegExp(
        r"\b(?:Kabupaten|Kab\.?|Kota)\s+([^:,\n]+)",
        caseSensitive: false,
      ).firstMatch(segment);
      if (nameMatch != null) {
        final nameRaw = nameMatch.group(1)?.trim();
        final name = nameRaw == null ? null : cleanDistrictName(nameRaw);
        List<String>? subs;
        final colonIndex = segment.indexOf(':');
        if (colonIndex >= 0) {
          var listPart = segment.substring(colonIndex + 1);
          final paraIndex = listPart.indexOf('\n\n');
          if (paraIndex >= 0) listPart = listPart.substring(0, paraIndex);
          subs = parseSubdistrictList(listPart);
        }
        if (name != null && name.isNotEmpty) {
          results.add(NowcastDistrictModel(name: name, subdistricts: subs));
        }
      }
    }
    if (results.isNotEmpty) return results;
  }

  final regSimple = RegExp(
    r"\b(?:Kabupaten|Kab\.?|Kota)\s+([A-Za-z0-9\-\s]+?)(?:[;:\n]|\band\b|\bdan\b|$)",
    caseSensitive: false,
  );
  final found = <String>{};
  for (final m in regSimple.allMatches(text)) {
    final name = m.group(1)?.trim();
    if (name != null && name.isNotEmpty) found.add(cleanDistrictName(name));
  }
  if (found.isNotEmpty) {
    return found.map((n) => NowcastDistrictModel(name: n)).toList();
  }
  return null;
}
