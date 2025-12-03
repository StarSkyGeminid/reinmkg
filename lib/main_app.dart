import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'core/localization/l10n/generated/strings.dart';
import 'package:reinmkg/core/dependencies_injection.dart';
import 'package:reinmkg/features/general/location/presentation/cubit/location_cubit.dart';
import 'package:reinmkg/features/general/settings/presentation/cubit/settings_cubit.dart';

import 'core/router.dart';
import 'core/themes/themes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    TextTheme textTheme = createTextTheme(
      context,
      "Plus Jakarta Sans",
      "Plus Jakarta Sans",
    );
    MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SettingsCubit>()..initial()),
        BlocProvider(create: (_) => sl<LocationCubit>()..refreshLocation()),
      ],
      child: LayoutBuilder(
        builder: (context, __) {
          AppRoute.setStream(context);

          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (_, state) {
              switch (state) {
                case SettingsInitial():
                case SettingsLoading():
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: Strings.localizationsDelegates,
                    supportedLocales: Strings.supportedLocales,
                    locale: const Locale('en'),
                    title: 'ReinMKG',
                    theme: theme.dark(),
                    home: const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
                  );
                case SettingsLoaded():
                  Intl.systemLocale = state.language;

                  return MaterialApp.router(
                    routerConfig: AppRoute.router,
                    localizationsDelegates: [
                      Strings.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    debugShowCheckedModeBanner: false,
                    builder: (BuildContext context, Widget? child) {
                      final MediaQueryData data = MediaQuery.of(context);

                      return MediaQuery(
                        data: data.copyWith(
                          alwaysUse24HourFormat: true,
                          textScaler: const TextScaler.linear(1),
                        ),
                        child: child!,
                      );
                    },
                    title: 'ReinMKG',
                    theme: theme.dark(),
                    locale: Locale(state.language),
                    supportedLocales: Strings.supportedLocales,
                    themeMode: ThemeMode.dark,
                  );
                case SettingsFailure():
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: Strings.localizationsDelegates,
                    supportedLocales: Strings.supportedLocales,
                    locale: const Locale('en'),
                    title: 'ReinMKG',
                    theme: theme.dark(),
                    home: Scaffold(body: Center(child: Text(state.message))),
                  );
                default:
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: Strings.localizationsDelegates,
                    supportedLocales: Strings.supportedLocales,
                    locale: const Locale('en'),
                    title: 'ReinMKG',
                    theme: theme.dark(),
                    home: Scaffold(
                      body: Center(child: Text('Unknown state: $state')),
                    ),
                  );
              }
            },
          );
        },
      ),
    );
  }
}
