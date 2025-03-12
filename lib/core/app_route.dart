import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reinmkg/features/features.dart';
import 'package:go_router/go_router.dart';

import '../dependencies_injection.dart';
import '../utils/helper/go_router_refresh_stream.dart';

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),

  dashboard("/dashboard"),
  weather("/weather"),
  earthquake("/earthquake"),
  settings("/settings"),

  radar('/radar'),
  satelite('/satelite'),
  nowcast('/nowcast'),
  maritimeWeather('/maritime_weather'),
  ;

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
          return MultiBlocProvider(
            providers: [
              BlocProvider<CurrentWeatherCubit>(
                create: (context) => sl(),
              ),
              BlocProvider<WeeklyWeatherCubit>(
                create: (context) => sl(),
              ),
              BlocProvider<DailyWeatherCubit>(
                create: (context) => sl(),
              ),
              BlocProvider<LastEarthquakeFeltBloc>(
                create: (context) => sl(),
              ),
              BlocProvider<RecentEarthquakeBloc>(
                create: (context) => sl(),
              ),
              BlocProvider<FaultLineDataCubit>(
                create: (context) => sl()..getFaultLine(),
              ),
            ],
            child: MainPage(navigationShell: navigationShell),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.dashboard.path,
                name: Routes.dashboard.name,
                builder: (_, __) => MultiBlocProvider(
                  providers: [
                    BlocProvider<SelectableEarthquakeBloc>(
                      create: (context) => sl()
                        ..add(
                          const SelectableEarthquakeEvent.started(),
                        ),
                    ),
                    BlocProvider<FaultLineDataCubit>(
                      create: (context) => sl()..getFaultLine(),
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
                    BlocProvider<MoonPositionCubit>(
                      create: (context) => sl(),
                    ),
                    BlocProvider<SunPositionCubit>(
                      create: (context) => sl(),
                    ),
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
                    BlocProvider<SelectableEarthquakeBloc>(
                      create: (context) =>
                          sl()..add(const SelectableEarthquakeEvent.started()),
                    ),
                    BlocProvider<EarthquakeHistoriesCubit>(
                      create: (context) => sl()..getEarthquakes(),
                    ),
                    BlocProvider<RegionBorderCubit>(
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
    refreshListenable:
        GoRouterRefreshStream(context.read<LocationCubit>().stream),
    redirect: (_, GoRouterState state) {
      final locationCubit = context.read<LocationCubit>();

      if (locationCubit.state.status.isLoading) {
        return Routes.splashScreen.path;
      } else if (locationCubit.state.status.isSuccess &&
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
              BlocProvider<CloudRadarsCubit>(
                create: (context) => sl()..getCloudRadars(),
              ),
              BlocProvider<NearestCloudRadarCubit>(
                create: (context) => sl(),
              ),
              BlocProvider<RegionBorderCubit>(
                create: (context) => sl()..getRegionBorder(),
              ),
              BlocProvider<SelectableRadarBloc>(
                create: (context) =>
                    sl()..add(const SelectableRadarEvent.started()),
              ),
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
              BlocProvider<SateliteImagesCubit>(
                create: (context) => sl()..getSateliteImages(),
              ),
              BlocProvider<RegionBorderCubit>(
                create: (context) => sl(),
              ),
            ],
            child: const SatelitePage(),
          ),
        ),
      ),
      GoRoute(
        path: Routes.nowcast.path,
        name: Routes.nowcast.name,
        pageBuilder: (context, state) => buildPageSlideUpAnimation(
            context: context, state: state, child: const NowcastPage()),
      ),
      GoRoute(
        path: Routes.maritimeWeather.path,
        name: Routes.maritimeWeather.name,
        pageBuilder: (context, state) => buildPageSlideUpAnimation(
          context: context,
          state: state,
          child: MultiBlocProvider(
            providers: [
              BlocProvider<WaterWaveCubit>(
                create: (context) => sl()..getWaterWaves(),
              ),
              BlocProvider<MaritimeBoundariesCubit>(
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
          child);
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

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
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

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
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
