import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/localization/l10n/generated/strings.dart';

extension DateTimeExtension on DateTime {
  String toDateLocalShort({BuildContext? context}) {
    return DateFormat(
      'dd MMM yyyy',
      context != null ? Strings.of(context).localeName : null,
    ).format(toLocal());
  }

  String toTimeString({bool second = true}) {
    return DateFormat('HH:mm${second ? ':ss' : ''}').format(toLocal());
  }

  String toDateTimeString({bool second = true, BuildContext? context}) {
    return DateFormat(
      'dd MMM yyyy HH:mm${second ? ':ss' : ''}',
      context != null ? Strings.of(context).localeName : null,
    ).format(toLocal());
  }

  DateTime roundDown({Duration delta = const Duration(seconds: 1)}) {
    return DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch - millisecondsSinceEpoch % delta.inMilliseconds);
  }

  String toId() {
    return DateFormat('yyyyMMddkkmmss')
        .format(roundDown(delta: const Duration(seconds: 1)));
  }
}
