import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reinmkg/core/enumerate/enumerate.dart';
import 'package:reinmkg/utils/utils.dart';

import '../../../../core/app_route.dart';
import '../../../../core/localization/l10n/generated/strings.dart';
import '../../../cubit/general/settings/settings_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> with MainPrefsMixin {
  String _appVersion = '0.0.1';

  @override
  void initState() {
    super.initState();

    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    PackageInfo.fromPlatform().then((info) {
      _appVersion = info.version;

      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            Strings.of(context).generalSettingsText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Column(
                children: [
                  ListTile(
                    title: Text(Strings.of(context).unitText),
                    subtitle: Text(Strings.of(context)
                        .unitType(state.measurementUnit.name)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: context.read<SettingsCubit>(),
                            child: const UnitSheet(),
                          );
                        },
                      );
                    },
                  ),
                  ListTile(
                    title: Text(Strings.of(context).languageText),
                    subtitle: Text(Strings.of(context)
                        .languageFromLocale(state.language ?? 'en')),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: context.read<SettingsCubit>(),
                            child: const LanguageSheet(),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Lisensi',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ListTile(
                title: const Text('Lisensi Aplikasi'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              // const Divider(height: 1),
              ListTile(
                title: const Text('Lisensi Opensource'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showLicensePage(context: context);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Center(child: Text(Strings.of(context).version(_appVersion))),
        const SizedBox(height: 32),
      ],
    );
  }
}

class GlossaryItem extends StatelessWidget {
  final String term;
  final String definition;

  const GlossaryItem({
    super.key,
    required this.term,
    required this.definition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          term,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(
          definition,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class UnitSheet extends StatelessWidget {
  const UnitSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              Strings.of(context).unitSelectionTypeText,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return SheetValueSelection(
                onSelectionChanged: (int index) {
                  BlocProvider.of<SettingsCubit>(context)
                      .updateUnit(MeasurementUnit.values[index]);
                  Navigator.pop(context);
                },
                value: MeasurementUnit.values
                    .map((e) => Strings.of(context).unitType(e.name))
                    .toList(),
                selectedValue:
                    Strings.of(context).unitType(state.measurementUnit.name),
              );
            },
          )
        ],
      ),
    );
  }
}

class LanguageSheet extends StatefulWidget {
  const LanguageSheet({super.key});

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  final _value = ['en', 'id'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              Strings.of(context).languageSelectionText,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return SheetValueSelection(
                onSelectionChanged: (int index) {
                  BlocProvider.of<SettingsCubit>(context)
                      .updateLanguage(_value[index]);
                  Navigator.pop(context);
                },
                value: _value
                    .map((e) => Strings.of(context).languageFromLocale(e))
                    .toList(),
                selectedValue: Strings.of(context)
                    .languageFromLocale(state.language ?? 'en'),
              );
            },
          )
        ],
      ),
    );
  }
}

class SheetValueSelection extends StatelessWidget {
  const SheetValueSelection({
    super.key,
    required this.value,
    required this.selectedValue,
    required this.onSelectionChanged,
  });

  final List<String> value;
  final String selectedValue;
  final void Function(int) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: value.length,
      itemBuilder: (context, index) {
        return _buildTile(context, value[index], index);
      },
    );
  }

  Widget _buildTile(BuildContext context, String value, int index) {
    return ListTile(
      title: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: Radio<String>(
        value: value,
        groupValue: selectedValue,
        onChanged: (_) {
          onSelectionChanged(index);
        },
      ),
      onTap: () {
        onSelectionChanged(index);
      },
    );
  }
}
