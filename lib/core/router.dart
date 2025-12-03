import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reinmkg/features/general/main/presentation/pages/main_page.dart';

import '../features/features.dart';
import 'core.dart';

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),

  dashboard("/dashboard"),
  weather("/weather"),
  earthquake("/earthquake"),
  seismicPlayback("/seismic_playback"),
  settings("/settings"),

  radar('/radar'),
  satelite('/satelite'),
  nowcast('/nowcast'),
  maritimeWeather('/maritime_weather');

  const Routes(this.path);

  final String path;
}

class AppRoute {
  static late BuildContext context;

  AppRoute.setStream(BuildContext ctx) {
    context = ctx;
  }

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splashScreen.path,
        name: Routes.splashScreen.name,
        builder: (_, __) => const SplashScreenPage(),
      ),
      GoRoute(
        path: Routes.root.path,
        name: Routes.root.name,
        redirect: (_, __) => Routes.dashboard.path,
      ),
      ..._dashboardSubMenu,
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainPage(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.dashboard.path,
                name: Routes.dashboard.name,
                builder: (_, __) => MultiBlocProvider(
                  providers: [
                    BlocProvider<CurrentWeatherCubit>(
                      create: (context) => sl()..getCurrentWeather(),
                    ),
                    BlocProvider<WeeklyWeatherCubit>(
                      create: (context) => sl()..getWeeklyWeather(),
                    ),
                    BlocProvider<EarthquakeCubit>(
                      create: (context) => sl()..getLastEarthquake(),
                    ),
                    BlocProvider<NowcastCubit>(
                      create: (context) => sl()..getNowcasts(),
                    ),
                  ],
                  child: const DashboardPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.weather.path,
                name: Routes.weather.name,
                builder: (_, __) => MultiBlocProvider(
                  providers: [
                    BlocProvider<CurrentWeatherCubit>(
                      create: (context) => sl()..getCurrentWeather(),
                    ),
                    BlocProvider<DailyWeatherCubit>(
                      create: (context) => sl()..getDailyWeather(),
                    ),
                    BlocProvider<CelestialCubit>(create: (context) => sl()),
                  ],
                  child: const WeatherPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.earthquake.path,
                name: Routes.earthquake.name,
                builder: (_, state) => MultiBlocProvider(
                  providers: [
                    BlocProvider<FaultLineDataCubit>(
                      create: (context) => sl()..getFaultLine(),
                    ),
                    BlocProvider<EarthquakeCubit>(
                      create: (context) => sl()..startListening(),
                    ),
                    BlocProvider<EarthquakeHistoriesCubit>(
                      create: (context) => sl()..getHistories(),
                    ),
                    BlocProvider<SelectableEarthquakeCubit>(
                      create: (context) => sl(),
                    ),
                    BlocProvider<RegionBorderOverlayCubit>(
                      create: (context) => sl()..getRegionBorder(),
                    ),
                  ],
                  child: EarthquakePage(heroKey: state.extra as String?),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings.path,
                name: Routes.settings.name,
                builder: (_, __) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
    initialLocation: Routes.splashScreen.path,
    routerNeglect: true,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: GoRouterRefreshStream(
      context.read<LocationCubit>().stream,
    ),
    redirect: (_, GoRouterState state) {
      final locationCubit = context.read<LocationCubit>();

      if (locationCubit.state is! LocationLoaded) {
        return Routes.splashScreen.path;
      } else if (locationCubit.state is LocationLoaded &&
          state.fullPath == Routes.splashScreen.path) {
        return Routes.dashboard.path;
      }

      return null;
    },
  );

  static List<RouteBase> get _dashboardSubMenu {
    return [
      GoRoute(
        path: Routes.radar.path,
        name: Routes.radar.name,
        pageBuilder: (context, state) => buildPageSlideUpAnimation(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<RadarSelectionCubit>(create: (context) => sl()),
              BlocProvider<PlaybackCubit>(create: (context) => sl()),
            ],
            child: const RadarPage(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.satelite.path,
        name: Routes.satelite.name,
        pageBuilder: (context, state) => buildPageSlideUpAnimation(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SateliteCubit>(
                create: (context) => sl()..getImages(),
              ),
              BlocProvider<PlaybackCubit>(create: (context) => sl()),
              BlocProvider<RegionBorderOverlayCubit>(create: (context) => sl()),
            ],
            child: const SatelitePage(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.seismicPlayback.path,
        name: Routes.seismicPlayback.name,
        pageBuilder: (context, state) => buildPageSlideUpAnimation(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SeismicPlaybackCubit>(create: (context) => sl()),
            ],
            child: SeismicPlaybackPage(
              eventId: (state.extra as Map<String, dynamic>)['eventId'] ?? '',
              time: (state.extra as Map<String, dynamic>)['time'],
              latitude:
                  (state.extra as Map<String, dynamic>)['latitude'] ?? 0.0,
              longitude:
                  (state.extra as Map<String, dynamic>)['longitude'] ?? 0.0,
              magnitude:
                  (state.extra as Map<String, dynamic>)['magnitude'] ?? 0.0,
            ),
          ),
        ),
      ),
      GoRoute(
        path: Routes.nowcast.path,
        name: Routes.nowcast.name,
        pageBuilder: (context, state) {
          final nowcast = state.extra as WeatherNowcastEntity?;

          return buildPageSlideUpAnimation(
            context: context,
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<NowcastCubit>(
                  create: (context) => sl()..getNowcasts(),
                ),
                BlocProvider<ProvinceBorderOverlayCubit>(
                  create: (context) => sl(),
                ),
              ],
              child: NowcastPage(nowcast: nowcast),
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.maritimeWeather.path,
        name: Routes.maritimeWeather.name,
        pageBuilder: (context, state) => buildPageSlideUpAnimation(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<MaritimeWeatherCubit>(
                create: (context) => sl()..load(),
              ),
              BlocProvider<MaritimeBoundariesCubit>(create: (context) => sl()),
              BlocProvider<MaritimeWeatherDetailCubit>(
                create: (context) => sl(),
              ),
            ],
            child: const MaritimeWeatherPage(),
          ),
        ),
      ),
    ];
  }
}

CustomTransitionPage<void> buildPageWithoutAnimation({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 0),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );
}

CustomTransitionPage<void> buildPageSlideAnimation({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

CustomTransitionPage<void> buildPageSlideUpAnimation({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}

// CustomTransitionPage buildPageWithDefaultTransition<T>({
//   required BuildContext context,
//   required GoRouterState state,
//   required Widget child,
// }) {
//   return CustomTransitionPage<T>(
//     key: state.pageKey,
//     child: child,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) =>
//         FadeTransition(opacity: animation, child: child),
//   );
// }
