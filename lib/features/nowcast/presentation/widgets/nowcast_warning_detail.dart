import 'package:flutter/material.dart';
import 'package:reinmkg/core/utils/extension/datetime.dart';
import 'package:reinmkg/core/localization/l10n/generated/strings.dart';

import '../../domain/entities/weather_nowcast_entity.dart';

class NowcastWarningDetail extends StatefulWidget {
  const NowcastWarningDetail({
    super.key,
    required this.scrollController,
    required this.nowcast,
  });

  final ScrollController scrollController;
  final WeatherNowcastEntity nowcast;

  @override
  State<NowcastWarningDetail> createState() => _NowcastWarningDetailState();
}

class _NowcastWarningDetailState extends State<NowcastWarningDetail> {
  @override
  Widget build(BuildContext context) {
    final now = widget.nowcast;

    return ListView(
      controller: widget.scrollController,
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      children: [
        Text(
          now.headline ?? Strings.of(context).dash,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.of(context).validFrom,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      now.validFrom?.toDateTimeString(
                            withSecond: false,
                            withTimezone: true,
                          ) ??
                          Strings.of(context).dash,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.of(context).validUntil,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      now.validUntil?.toDateTimeString(
                            withSecond: false,
                            withTimezone: true,
                          ) ??
                          Strings.of(context).dash,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (now.imageUrl != null && now.imageUrl!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              now.imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => const SizedBox(),
            ),
          ),
        if (now.imageUrl != null && now.imageUrl!.isNotEmpty)
          const SizedBox(height: 12),
        if (now.description != null)
          Text(now.description!, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 12),

        buildDistricts(
          Strings.of(context).affectedDistricts,
          now.affectedDistricts,
        ),
        buildDistricts(
          Strings.of(context).spreadDistricts,
          now.spreadDistricts,
        ),

        if (now.event != null) ...[
          const SizedBox(height: 12),
          Text(
            Strings.of(context).event,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(now.event!),
        ],

        if (now.severity != null) ...[
          const SizedBox(height: 12),
          Text(
            Strings.of(context).severity,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(now.severity!),
        ],

        if (now.category != null) ...[
          const SizedBox(height: 12),
          Text(
            Strings.of(context).category,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(now.category!),
        ],

        if (now.tags != null && now.tags!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            Strings.of(context).tags,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: now.tags!.map((t) => Chip(label: Text(t))).toList(),
          ),
        ],

        const SizedBox(height: 12),
        if (now.source != null)
          Text(
            '${Strings.of(context).source}: ${now.source!}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget buildDistricts(String title, List? districts) {
    if (districts == null || districts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 6),
        ...districts.map((d) {
          final name = d?.name ?? d?.toString() ?? Strings.of(context).dash;
          final subs = (d?.subdistricts ?? <String>[]) as List?;

          return ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 0,
            ),
            title: Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            children: subs != null && subs.isNotEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: subs.map<Widget>((s) {
                          return Chip(label: Text(s?.toString() ?? ''));
                        }).toList(),
                      ),
                    ),
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(Strings.of(context).emdash),
                    ),
                  ],
          );
        }),
      ],
    );
  }
}
