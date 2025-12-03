import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDateLocalShort({BuildContext? context}) {
    String? locale = context != null
        ? Localizations.localeOf(context).toString()
        : null;

    return DateFormat('dd MMM yyyy', locale).format(toLocal());
  }

  String toTimeString({bool second = true}) {
    return DateFormat('HH:mm${second ? ':ss' : ''}').format(toLocal());
  }

  String toDateTimeString({bool withSecond = true, bool withTimezone = false, BuildContext? context}) {
    String? locale = context != null
        ? Localizations.localeOf(context).toString()
        : null;
    final timeZoneString = withTimezone ? ' ${_tzAbbrev(timeZoneOffset)}' : '';
    final time = DateFormat(
      'dd MMM yyyy HH:mm${withSecond ? ':ss' : ''}',
      locale,
    ).format(toLocal());

    return '$time $timeZoneString';
  }

  DateTime roundDown({Duration delta = const Duration(seconds: 1)}) {
    return DateTime.fromMillisecondsSinceEpoch(
      millisecondsSinceEpoch - millisecondsSinceEpoch % delta.inMilliseconds,
    );
  }

  String toId() {
    return DateFormat(
      'yyyyMMddkkmmss',
    ).format(roundDown(delta: const Duration(seconds: 1)));
  }

  String _tzAbbrev(Duration offset) {
    // Indonesia timezones: WIB=UTC+7, WITA=UTC+8, WIT=UTC+9
    final totalMinutes = offset.inMinutes;
    final hours = totalMinutes ~/ 60;

    if (hours == 7) return 'WIB';
    if (hours == 8) return 'WITA';
    if (hours == 9) return 'WIT';

    // fallback to UTC offset like UTC+03:00
    final sign = totalMinutes >= 0 ? '+' : '-';
    final absMinutes = totalMinutes.abs();
    final h = (absMinutes ~/ 60).toString().padLeft(2, '0');
    final m = (absMinutes % 60).toString().padLeft(2, '0');
    return 'UTC$sign$h:$m';
  }
}
