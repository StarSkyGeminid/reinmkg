import 'package:dio/dio.dart';
import 'package:reinmkg/core/core.dart';
import 'package:reinmkg/features/features.dart';
import 'package:reinmkg/utils/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'data/data.dart';
import 'domain/domain.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isSharedPrefsEnable = true,
  bool isFloorEnable = true,
  String prefixBox = '',
}) async {
  if (isUnitTest) {
    await sl.reset();
  }

  sl.registerSingleton<Dio>(
    Dio(
      BaseOptions(connectTimeout: const Duration(seconds: 30), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer f2Hu6lYhfa",
      }),
    ),
  );

  sl.registerSingleton<InternetConnectionChecker>(InternetConnectionChecker());
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl(sl()));

  if (isSharedPrefsEnable) {
    await _initSharedPrefs(
      isUnitTest: isUnitTest,
      prefixBox: prefixBox,
    );
  }

  if (isFloorEnable) {
    await _initFloor(
      isUnitTest: isUnitTest,
    );
  }

  _dataSources();
  _repositories();
  _useCase();
  _bloc();
  _cubit();
}

Future<void> _initSharedPrefs({
  bool isUnitTest = false,
  String prefixBox = '',
}) async {
  await MainPrefsMixin.initSharedPrefs(prefixBox);

  sl.registerSingleton<MainPrefsMixin>(MainPrefsMixin());
}

Future<void> _initFloor({
  bool isUnitTest = true,
}) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  sl.registerSingleton<AppDatabase>(database);
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<LocationRepository>(
      () => LocationRepositoryImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<RadarRepository>(
      () => RadarRepositoryImpl(sl(), sl()));

  sl.registerLazySingleton<EarthquakeRepository>(
      () => EarthquakeRepositoryImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<GeojsonRepository>(
      () => GeojsonRepositoryImpl(sl()));

  sl.registerLazySingleton<CelestialRepository>(
      () => CelestialRepositoryImpl(sl()));
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<RemoteLocationService>(
    () => RemoteLocationServiceImpl(sl()),
  );
  sl.registerLazySingleton<RemoteWeatherService>(
    () => RemoteWeatherServiceImpl(sl()),
  );
  sl.registerLazySingleton<RemoteRadarService>(
    () => RemoteRadarServiceImpl(sl()),
  );
  sl.registerLazySingleton<RemoteEarthquakeService>(
    () => RemoteEarthquakeServiceImpl(),
  );

  sl.registerLazySingleton<LocalLocationService>(
    () => LocalLocationService(),
  );
  sl.registerLazySingleton<LocalWeatherService>(
    () => LocalWeatherServiceImpl(sl()),
  );
  sl.registerLazySingleton<LocalEarthquakeService>(
    () => LocalEarthquakeServiceImpl(sl()),
  );
  sl.registerLazySingleton<LocalGeojsonService>(
    () => LocalGeojsonServiceImpl(),
  );

  sl.registerSingleton<CelestialCalculator>(CelestialCalculator());
}

void _useCase() {
  sl.registerLazySingleton(() => GetCurrentLocation(sl()));

  sl.registerLazySingleton(() => GetCurrentWeather(sl()));
  sl.registerLazySingleton(() => GetWeeklyWeathers(sl()));
  sl.registerLazySingleton(() => GetDailyWeathers(sl()));

  sl.registerLazySingleton(() => GetWaterWave(sl()));
  sl.registerLazySingleton(() => GetCloudRadars(sl()));
  sl.registerLazySingleton(() => GetSateliteImages(sl()));
  sl.registerLazySingleton(() => GetNearestCloudRadar(sl()));
  sl.registerLazySingleton(() => SetSelectedRadar(sl()));
  sl.registerLazySingleton(() => StreamSelectedRadar(sl()));

  sl.registerLazySingleton(() => SetSelectedEarthquake(sl()));
  sl.registerLazySingleton(() => GetSelectedEarthquake(sl()));
  sl.registerLazySingleton(() => GetLastEarthquakeFelt(sl()));
  sl.registerLazySingleton(() => GetListEarthquakesFelt(sl()));
  sl.registerLazySingleton(() => GetEarthquakesByTypeUsecase(sl()));
  sl.registerLazySingleton(() => GetEarthquakeHistories(sl()));
  sl.registerLazySingleton(() => GetOneWeekEarthquakes(sl()));
  sl.registerLazySingleton(() => GetRecentEarthquake(sl()));
  sl.registerLazySingleton(() => StreamLastEarthquakeFelt(sl()));
  sl.registerLazySingleton(() => StreamRecentEarthquake(sl()));

  sl.registerLazySingleton(() => GetFaultLineUsecase(sl()));
  sl.registerLazySingleton(() => GetProvinceBorderUsecase(sl()));
  sl.registerLazySingleton(() => GetMaritimeBoundariesUsecase(sl()));

  sl.registerLazySingleton(() => GetSunData(sl()));
  sl.registerLazySingleton(() => GetMoonData(sl()));
}

void _bloc() {
  sl.registerFactory(() => LastEarthquakeFeltBloc(sl()));
  sl.registerFactory(() => RecentEarthquakeBloc(sl()));
  sl.registerFactory(() => SelectableEarthquakeBloc(sl(), sl()));
  sl.registerFactory(() => SelectableRadarBloc(sl(), sl()));
  sl.registerFactory(() => SearchCloudRadarBloc(sl()));
}

void _cubit() {
  sl.registerFactory(() => SettingsCubit());
  sl.registerFactory(() => LocationCubit(sl()));

  sl.registerFactory(() => CurrentWeatherCubit(sl()));
  sl.registerFactory(() => WeeklyWeatherCubit(sl()));
  sl.registerFactory(() => DailyWeatherCubit(sl()));

  sl.registerFactory(() => WaterWaveCubit(sl()));
  sl.registerFactory(() => CloudRadarsCubit(sl()));
  sl.registerFactory(() => NearestCloudRadarCubit(sl()));
  sl.registerFactory(() => SateliteImagesCubit(sl()));

  sl.registerFactory(() => OneWeekEarthquakesCubit(sl()));
  sl.registerFactory(() => EarthquakeHistoryByTypeCubit(sl()));
  sl.registerFactory(() => EarthquakeHistoriesCubit(sl()));

  sl.registerFactory(() => FaultLineDataCubit(sl()));
  sl.registerFactory(() => RegionBorderCubit(sl()));
  sl.registerFactory(() => MaritimeBoundariesCubit(sl()));

  sl.registerFactory(() => MoonPositionCubit(sl()));
  sl.registerFactory(() => SunPositionCubit(sl()));
}
