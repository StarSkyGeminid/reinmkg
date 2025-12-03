import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/utils/extension/datetime.dart';

import '../../domain/entities/earthquake_entity.dart';
import '../../domain/entities/warning_zone_entity.dart';
import 'package:reinmkg/features/earthquake/domain/entities/tsunami_entity.dart';

class TsunamiInfo extends StatefulWidget {
  const TsunamiInfo({super.key, required this.earthquake});

  final EarthquakeEntity earthquake;

  @override
  State<TsunamiInfo> createState() => _TsunamiInfoState();
}

class _TsunamiInfoState extends State<TsunamiInfo> {
  bool _expandedWarningZones = false;
  @override
  Widget build(BuildContext context) {
    return _tsunamiView(widget.earthquake);
  }

  Widget _tsunamiView(EarthquakeEntity earthquake) {
    final tsunami = earthquake.tsunamiData;

    if (tsunami == null) return const SizedBox.shrink();

    final warningZones = tsunami.warningZone ?? <WarningZoneEntity>[];

    final sortedWarningZones = [...warningZones];
    sortedWarningZones.sort((a, b) {
      int sa = a.level?.index ?? 0;
      int sb = b.level?.index ?? 0;
      return sb.compareTo(sa);
    });

    final now = DateTime.now();
    final int firstFutureIndex = sortedWarningZones.indexWhere(
      (w) => w.dateTime != null && w.dateTime!.isAfter(now),
    );
    final WarningZoneEntity? firstFutureZone = firstFutureIndex >= 0
        ? sortedWarningZones[firstFutureIndex]
        : null;

    final displayed = (_expandedWarningZones
        ? sortedWarningZones
        : sortedWarningZones.take(3).toList());

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _tsunamiMapData(tsunami, warningZones),
          if (warningZones.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Symbols.globe_asia_rounded),
                      ),
                      Text(
                        Strings.of(context).tsunamiWarningZonesLabel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRect(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOut,
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < displayed.length; i++)
                            _warningZoneItem(
                              displayed[i],
                              showFirstFutureIcon:
                                  displayed[i] == firstFutureZone,
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (sortedWarningZones.length > 3)
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => setState(() {
                            _expandedWarningZones = !_expandedWarningZones;
                          }),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4.0,
                              horizontal: 6.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedRotation(
                                  turns: _expandedWarningZones ? 0.5 : 0.0,
                                  duration: const Duration(milliseconds: 220),
                                  child: Icon(
                                    Icons.expand_more,
                                    size: 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _expandedWarningZones
                                      ? Strings.of(context).showLessLabel
                                      : Strings.of(context).showMoreCount(
                                          sortedWarningZones.length - 3,
                                        ),
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Column _tsunamiMapData(
    TsunamiEntity tsunami,
    List<WarningZoneEntity> warningZones,
  ) {
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Symbols.warning_rounded),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    Strings.of(context).tsunamiLabel,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    tsunami.wzmapUrl != null || warningZones.isNotEmpty
                        ? Strings.of(context).tsunamiWarningInfoAvailable
                        : Strings.of(context).tsunamiNoWarningData,
                  ),
                ],
              ),
            ),
          ],
        ),

        if (tsunami.wzmapUrl != null ||
            tsunami.ttmapUrl != null ||
            tsunami.sshmmapUrl != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 116,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (tsunami.wzmapUrl != null)
                    _mapThumbnail(
                      Strings.of(context).mapLabelWZ,
                      tsunami.wzmapUrl!,
                    ),
                  if (tsunami.ttmapUrl != null)
                    _mapThumbnail(
                      Strings.of(context).mapLabelTT,
                      tsunami.ttmapUrl!,
                    ),
                  if (tsunami.sshmmapUrl != null)
                    _mapThumbnail(
                      Strings.of(context).mapLabelSSM,
                      tsunami.sshmmapUrl!,
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _warningZoneItem(
    WarningZoneEntity wz, {
    bool showFirstFutureIcon = false,
  }) {
    final level = wz.level;

    Color levelColor = Colors.orange;
    String levelLabel = level?.name ?? '-';

    if (level != null) {
      if (level.isAwas) {
        levelColor = Color(0xFFFC3535);
      } else if (level.isSiaga) {
        levelColor = Color(0xFFFDB935);
      } else if (level.isWaspada) {
        levelColor = Color(0xFFFAFB35);
      }
    }

    final when = wz.dateTime != null
        ? wz.dateTime?.toDateTimeString(withSecond: true, withTimezone: true)
        : '-';

    final location = [
      wz.province,
      wz.district,
    ].where((e) => e != null && e.isNotEmpty).join(' - ');

    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: levelColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Symbols.tsunami_rounded, color: levelColor, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(location.isNotEmpty ? location : '-'),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$levelLabel • $when',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (showFirstFutureIcon) ...[
                      const SizedBox(width: 6),
                      Icon(
                        Symbols.fiber_manual_record_rounded,
                        size: 10,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mapThumbnail(String label, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: InteractiveViewer(
                      child: Image.network(
                        url,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          child: const Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 140,
                height: 80,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    child: const Center(child: Icon(Icons.broken_image)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 140,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
