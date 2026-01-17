import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:reinmkg/features/features.dart';

import 'core.dart';

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
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer f2Hu6lYhfa",
        },
      ),
    ),
  );

  if (isSharedPrefsEnable) {
    await _initSharedPrefs(isUnitTest: isUnitTest, prefixBox: prefixBox);
  }

  if (isFloorEnable) {
    await _initFloor(isUnitTest: isUnitTest);
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
  await SharedPrefsMixin.initSharedPrefs(prefixBox);

  sl.registerSingleton<SharedPrefsMixin>(SharedPrefsMixin());
}

Future<void> _initFloor({bool isUnitTest = true}) async {
  final database = await $FroomAppDatabase
      .databaseBuilder('app_database.db')
      .build();

  sl.registerSingleton<AppDatabase>(database);
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<GeojsonDataRepository>(
    () => RegionBorderOverlayRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<RadarRepository>(() => RadarRepositoryImpl(sl()));

  sl.registerLazySingleton<SateliteRepository>(
    () => SateliteRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<EarthquakeRepository>(
    () => EarthquakeRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<SeismicPlaybackRepository>(
    () => SeismicPlaybackRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<MaritimeWeatherRepository>(
    () => MaritimeWeatherRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<NowcastRepository>(
    () => NowcastRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<CelestialRepository>(
    () => CelestialRepositoryImpl(sl()),
  );
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<LocalGeojsonDataService>(
    () => LocalRegionBorderOverlayServiceImpl(),
  );

  sl.registerLazySingleton<RemoteLocationService>(
    () => RemoteLocationServiceImpl(sl()),
  );
  sl.registerLazySingleton<LocalLocationService>(
    () => LocalLocationServiceImpl(),
  );

  sl.registerLazySingleton<RemoteWeatherService>(
    () => RemoteWeatherServiceImpl(sl()),
  );
  sl.registerLazySingleton<LocalWeatherService>(
    () => LocalWeatherServiceImpl(sl()),
  );

  sl.registerLazySingleton<RemoteRadarService>(
    () => RemoteRadarServiceImpl(),
  );

  sl.registerLazySingleton<RemoteEarthquakeService>(
    () => RemoteEarthquakeServiceImpl(),
  );
  sl.registerLazySingleton<LocalEarthquakeService>(
    () => LocalEarthquakeServiceImpl(sl()),
  );

  sl.registerLazySingleton<RemoteSateliteService>(
    () => RemoteSateliteServiceImpl(sl()),
  );

  sl.registerLazySingleton<RemoteSeismicPlaybackService>(
    () => RemoteSeismicPlaybackServiceImpl(),
  );

  sl.registerLazySingleton<RemoteMaritimeWeatherService>(
    () => RemoteMaritimeWeatherServiceImpl(),
  );
  sl.registerLazySingleton<RemoteNowcastService>(
    () => RemoteNowcastServiceImpl(),
  );
  sl.registerLazySingleton<LocalCelestialService>(
    () => LocalCelestialServiceImpl(),
  );
}

void _useCase() {
  sl.registerLazySingleton<GetRegionBorderUsecase>(
    () => GetRegionBorderUsecase(sl()),
  );

  sl.registerLazySingleton<GetProvinceBorderUsecase>(
    () => GetProvinceBorderUsecase(sl()),
  );

  sl.registerLazySingleton<GetFaultLineUsecase>(
    () => GetFaultLineUsecase(sl()),
  );

  sl.registerLazySingleton<GetSettingsUsecase>(() => GetSettingsUsecase(sl()));
  sl.registerLazySingleton<SetLanguageUsecase>(() => SetLanguageUsecase(sl()));
  sl.registerLazySingleton<SetMeasurementUnitUsecase>(
    () => SetMeasurementUnitUsecase(sl()),
  );

  sl.registerLazySingleton<GetCurrentLocationUsecase>(
    () => GetCurrentLocationUsecase(sl()),
  );
  sl.registerLazySingleton<GetLastLocationUsecase>(
    () => GetLastLocationUsecase(sl()),
  );
  sl.registerLazySingleton<RefreshLocationUsecase>(
    () => RefreshLocationUsecase(sl()),
  );

  sl.registerLazySingleton<GetCurrentWeatherUsecase>(
    () => GetCurrentWeatherUsecase(sl()),
  );
  sl.registerLazySingleton<GetDailyWeatherUsecase>(
    () => GetDailyWeatherUsecase(sl()),
  );
  sl.registerLazySingleton<GetWeeklyWeatherUsecase>(
    () => GetWeeklyWeatherUsecase(sl()),
  );

  sl.registerLazySingleton<GetAllRadarsUsecase>(
    () => GetAllRadarsUsecase(sl()),
  );
  sl.registerLazySingleton<GetNearestRadarUsecase>(
    () => GetNearestRadarUsecase(sl()),
  );
  sl.registerLazySingleton<SearchRadarsUsecase>(
    () => SearchRadarsUsecase(sl()),
  );
  sl.registerLazySingleton<SetRadarTypeUsecase>(
    () => SetRadarTypeUsecase(sl()),
  );
  sl.registerLazySingleton<SetRadarUsecase>(() => SetRadarUsecase(sl()));
  sl.registerLazySingleton<WatchRadarImagesUsecase>(
    () => WatchRadarImagesUsecase(sl()),
  );

  sl.registerLazySingleton<GetSateliteImagesUsecase>(
    () => GetSateliteImagesUsecase(sl()),
  );
  // Earthquake usecases
  sl.registerLazySingleton<GetLastEarthquakeFelt>(
    () => GetLastEarthquakeFelt(sl()),
  );
  sl.registerLazySingleton<GetRecentEarthquake>(
    () => GetRecentEarthquake(sl()),
  );
  sl.registerLazySingleton<GetOneWeekEarthquakes>(
    () => GetOneWeekEarthquakes(sl()),
  );
  sl.registerLazySingleton<GetListEarthquakesFelt>(
    () => GetListEarthquakesFelt(sl()),
  );
  sl.registerLazySingleton<GetEarthquakeHistories>(
    () => GetEarthquakeHistories(sl()),
  );
  sl.registerLazySingleton<GetEarthquakesByType>(
    () => GetEarthquakesByType(sl()),
  );
  sl.registerLazySingleton<SetSelectedEarthquake>(
    () => SetSelectedEarthquake(sl()),
  );
  sl.registerLazySingleton<WatchSelectedEarthquake>(
    () => WatchSelectedEarthquake(sl()),
  );
  sl.registerLazySingleton<WatchLastEarthquakeFelt>(
    () => WatchLastEarthquakeFelt(sl()),
  );
  sl.registerLazySingleton<WatchRecentEarthquake>(
    () => WatchRecentEarthquake(sl()),
  );
  sl.registerLazySingleton<GetEarthquakePgaDataUsecase>(
    () => GetEarthquakePgaDataUsecase(sl()),
  );
  sl.registerLazySingleton<GetMaritimeBoundariesUsecase>(
    () => GetMaritimeBoundariesUsecase(sl()),
  );
  sl.registerLazySingleton<GetWaterWavesUsecase>(
    () => GetWaterWavesUsecase(sl()),
  );
  sl.registerLazySingleton<GetMaritimeWeatherDetailUsecase>(
    () => GetMaritimeWeatherDetailUsecase(sl()),
  );
  sl.registerLazySingleton<GetNowcastsUsecase>(() => GetNowcastsUsecase(sl()));

  sl.registerLazySingleton<GetCelestialDataUsecase>(
    () => GetCelestialDataUsecase(sl()),
  );
}

void _bloc() {
  // sl.registerFactory(() => RadarBloc(sl(), sl(), sl(), sl()));
}

void _cubit() {
  sl.registerFactory(() => RegionBorderOverlayCubit(sl()));
  sl.registerFactory(() => ProvinceBorderOverlayCubit(sl()));
  sl.registerFactory(() => PlaybackCubit());

  sl.registerFactory(() => FaultLineDataCubit(sl()));

  sl.registerFactory(() => SettingsCubit(sl(), sl(), sl()));
  sl.registerFactory(() => LocationCubit(sl(), sl(), sl()));

  sl.registerFactory(() => CurrentWeatherCubit(sl(), sl()));
  sl.registerFactory(() => DailyWeatherCubit(sl(), sl()));
  sl.registerFactory(() => WeeklyWeatherCubit(sl(), sl()));

  sl.registerFactory(() => RadarListCubit(sl(), sl()));
  sl.registerFactory(() => RadarSelectionCubit(sl(), sl(), sl(), sl()));

  sl.registerFactory(() => SateliteCubit(sl()));
  sl.registerFactory(() => MaritimeBoundariesCubit(sl()));

  sl.registerFactory(() => EarthquakeCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SelectableEarthquakeCubit(sl(), sl()));

  sl.registerFactory(() => EarthquakeHistoriesCubit(sl()));
  sl.registerFactory(() => EarthquakeHistoryByTypeCubit(sl()));
  sl.registerFactory(() => SeismicPlaybackCubit(sl()));

  sl.registerFactory(() => MaritimeWeatherCubit(sl()));
  sl.registerFactory(() => MaritimeWeatherDetailCubit(sl()));

  sl.registerFactory(() => NowcastCubit(sl()));

  sl.registerFactory(() => CelestialCubit(sl()));
}
