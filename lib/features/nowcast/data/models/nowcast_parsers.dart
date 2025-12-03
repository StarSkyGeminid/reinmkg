DateTime? tryParseDateWithTimezone(String? raw, String? timezone) {
  if (raw == null) return null;
  var candidate = raw.trim();
  if (candidate.contains(' ') && !candidate.contains('T')) {
    candidate = candidate.replaceFirst(' ', 'T');
  }
  if (timezone != null && timezone.startsWith('+')) {
    candidate = candidate + timezone;
  }
  return DateTime.tryParse(candidate);
}

List<String>? parseStringList(dynamic value) {
  if (value == null) return null;
  if (value is List) {
    return value.map((e) => e?.toString().trim()).whereType<String>().toList();
  }
  if (value is String) {
    return value
        .split(RegExp(r'[;,|\n]'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }
  return [value.toString()];
}

String cleanDistrictName(String raw) {
  var out = raw.replaceAll(
    RegExp(r'\b(Kabupaten|Kab\.?|Kota)\b', caseSensitive: false),
    '',
  );
  out = out.replaceAll(RegExp(r'[()\[\]]'), '');
  return out.replaceAll(RegExp(r'\s+'), ' ').trim();
}

List<String>? parseSubdistrictList(dynamic value) {
  if (value == null) return null;
  List<String> rawItems;
  if (value is List) {
    rawItems = value
        .map((e) => e?.toString() ?? '')
        .where((s) => s.isNotEmpty)
        .toList();
  } else if (value is String) {
    rawItems = value
        .split(RegExp(r'[;,/\n]'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  } else {
    rawItems = [value.toString()];
  }

  final cleaned = <String>[];
  for (var s in rawItems) {
    var out = s.replaceAll(
      RegExp(r'\b(Kecamatan|Kec\.?|Kelurahan|Desa)\b', caseSensitive: false),
      '',
    );
    out = out.replaceAll(
      RegExp(r'\b(Kabupaten|Kab\.?|Kota)\b', caseSensitive: false),
      '',
    );
    out = out.replaceAll(RegExp(r'[()\[\]]'), '');
    out = out.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (out.isNotEmpty) cleaned.add(out);
  }
  return cleaned.isEmpty ? null : cleaned;
}

Map<String, DateTime?> extractValidityRange(String? text) {
  if (text == null || text.trim().isEmpty) return {'from': null, 'to': null};
  final monthMap = {
    'januari': 1,
    'jan': 1,
    'februari': 2,
    'feb': 2,
    'maret': 3,
    'mar': 3,
    'april': 4,
    'apr': 4,
    'mei': 5,
    'juni': 6,
    'jun': 6,
    'juli': 7,
    'jul': 7,
    'agustus': 8,
    'agu': 8,
    'september': 9,
    'sep': 9,
    'oktober': 10,
    'okt': 10,
    'november': 11,
    'nov': 11,
    'desember': 12,
    'des': 12,
  };

  DateTime? buildFromParts(int day, int month, int year, String? timeStr) {
    try {
      var hour = 0;
      var minute = 0;
      if (timeStr != null && timeStr.isNotEmpty) {
        final t = timeStr.replaceAll('.', ':').trim();
        final parts = t.split(':');
        if (parts.isNotEmpty) hour = int.tryParse(parts[0]) ?? 0;
        if (parts.length > 1) {
          minute = int.tryParse(parts[1].padRight(2, '0')) ?? 0;
        }
      }
      return DateTime(year, month, day, hour, minute);
    } catch (_) {
      return null;
    }
  }

  DateTime? buildFlexible(
    String dayStr,
    String monthStr,
    String? yearStr,
    String? timeStr,
  ) {
    final day = int.tryParse(dayStr);
    if (day == null) return null;
    var month = int.tryParse(monthStr);
    month ??= monthMap[monthStr.toLowerCase().replaceAll(RegExp(r'\.'), '')];
    if (month == null) return null;
    final year = (yearStr != null && yearStr.isNotEmpty)
        ? int.tryParse(yearStr) ?? DateTime.now().year
        : DateTime.now().year;
    return buildFromParts(day, month, year, timeStr);
  }

  final tgl = RegExp(
    r'tgl\.?\s*(\d{1,2})\s+([A-Za-z\.]+)\s+(\d{4})\s*(?:pkl\.?|pukul)?\s*(\d{1,2}[.:]\d{2})?',
    caseSensitive: false,
  );
  final mTgl = tgl.firstMatch(text);
  DateTime? fromDate;
  if (mTgl != null) {
    fromDate = buildFlexible(
      mTgl.group(1)!,
      mTgl.group(2)!,
      mTgl.group(3),
      mTgl.group(4),
    );
  }

  final namedRange = RegExp(
    r'(\d{1,2})\s*([A-Za-z\.]+)\s*(\d{4})?\s*(?:pkl\.?|pukul)?\s*(\d{1,2}[.:]\d{2})?.{0,80}?(?:sampai|hingga|s/d|sd|to|-)\s*(\d{1,2})\s*([A-Za-z\.]+)\s*(\d{4})?\s*(?:pkl\.?|pukul)?\s*(\d{1,2}[.:]\d{2})?',
    caseSensitive: false,
  );
  final mNamed = namedRange.firstMatch(text);
  if (mNamed != null) {
    final f = buildFlexible(
      mNamed.group(1)!,
      mNamed.group(2)!,
      mNamed.group(3),
      mNamed.group(4),
    );
    final t = buildFlexible(
      mNamed.group(5)!,
      mNamed.group(6)!,
      mNamed.group(7),
      mNamed.group(8),
    );
    return {'from': f, 'to': t};
  }

  final numericRange = RegExp(
    r'(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{2,4})(?:\s*(\d{1,2}[.:]\d{2}))?.{0,60}?(?:-|–|hingga|sampai|sd|s/d)\s*(\d{1,2})[\/\-](\d{1,2})[\/\-](\d{2,4})(?:\s*(\d{1,2}[.:]\d{2}))?',
    caseSensitive: false,
  );
  final mNum = numericRange.firstMatch(text);
  if (mNum != null) {
    final f = buildFlexible(
      mNum.group(1)!,
      mNum.group(2)!,
      mNum.group(3),
      mNum.group(4),
    );
    final t = buildFlexible(
      mNum.group(5)!,
      mNum.group(6)!,
      mNum.group(7),
      mNum.group(8),
    );
    return {'from': f, 'to': t};
  }

  final untilTime = RegExp(
    r'(?:hingga|sampai|s/d|sd)\s*(?:pkl\.?|pukul)?\s*(\d{1,2}[.:]\d{2})',
    caseSensitive: false,
  );
  final mu = untilTime.firstMatch(text);
  if (mu != null) {
    final toTime = mu.group(1);
    if (toTime != null) {
      if (fromDate != null) {
        final parts = toTime.replaceAll('.', ':').split(':');
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = parts.length > 1
            ? int.tryParse(parts[1].padRight(2, '0')) ?? 0
            : 0;
        var tentative = DateTime(
          fromDate.year,
          fromDate.month,
          fromDate.day,
          hour,
          minute,
        );
        if (!tentative.isAfter(fromDate)) {
          tentative = tentative.add(const Duration(days: 1));
        }
        return {'from': fromDate, 'to': tentative};
      } else {
        final parts = toTime.replaceAll('.', ':').split(':');
        final hour = int.tryParse(parts[0]) ?? 0;
        final minute = parts.length > 1
            ? int.tryParse(parts[1].padRight(2, '0')) ?? 0
            : 0;
        final now = DateTime.now();
        final tentative = DateTime(now.year, now.month, now.day, hour, minute);
        return {'from': null, 'to': tentative};
      }
    }
  }

  final startPattern = RegExp(
    r'(?:mulai|berlaku pada|mulai pada)\s*(\d{1,2})\s*([A-Za-z\.]+)\s*(\d{4})?\s*(?:pkl\.?|pukul)?\s*(\d{1,2}[.:]\d{2})?',
    caseSensitive: false,
  );
  final ms = startPattern.firstMatch(text);
  if (ms != null) {
    final f = buildFlexible(
      ms.group(1)!,
      ms.group(2)!,
      ms.group(3),
      ms.group(4),
    );
    return {'from': f, 'to': null};
  }

  return {'from': null, 'to': null};
}

String? extractProvince(String? headline, String? description) {
  final combined = '${headline ?? ''} ${description ?? ''}'.trim();
  if (combined.isEmpty) return null;

  final patterns = [
    RegExp(
      r'\bWilayah\s+([^,\n]+?)(?:\s+tgl|\s+pkl|,|\n|$)',
      caseSensitive: false,
    ),
    RegExp(
      r'Peringatan\s+Dini\s+Cuaca(?:\s+Wilayah)?\s+([^,\n]+?)(?:\s+tgl|\s+pkl|,|\n|$)',
      caseSensitive: false,
    ),
    RegExp(r'Cuaca\s+([^,\n]+?)(?:\s+tgl|\s+pkl|,|\n|$)', caseSensitive: false),
  ];

  for (final p in patterns) {
    final m = p.firstMatch(combined);
    if (m != null) {
      final name = m.group(1)?.trim();
      if (name != null && name.isNotEmpty) {
        return name.replaceAll(RegExp(r'\s+'), ' ').trim();
      }
    }
  }

  return null;
}
