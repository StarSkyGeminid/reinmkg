import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/dependencies_injection.dart';
import 'package:reinmkg/features/features.dart';
import 'package:reinmkg/utils/helper/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    log.d(const String.fromEnvironment('ENV'));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SettingsCubit>()..initial()),
        BlocProvider(create: (_) => sl<LocationCubit>()..getLocation()),
      ],
      child: OKToast(
        child: ScreenUtilInit(
          designSize: const Size(375, 667),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, __) {
            AppRoute.setStream(context);

            return BlocBuilder<SettingsCubit, SettingsState>(
                builder: (_, state) {
              switch (state.status) {
                case BlocState.initial:
                case BlocState.loading:
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                case BlocState.success:
                  return MaterialApp.router(
                    routerConfig: AppRoute.router,
                    localizationsDelegates: const [
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
                    title: Constants.get.appName,
                    theme: themeDark(context),
                    darkTheme: themeDark(context),
                    locale: Locale(state.language ?? "en"),
                    supportedLocales: L10n.all,
                    themeMode: ThemeMode.dark,
                  );
                case BlocState.failure:
                  return Scaffold(
                    body: Text(state.message ?? 'Something Wrong'),
                  );
              }
            });
          },
        ),
      ),
    );
  }
}
