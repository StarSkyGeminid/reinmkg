import '../enumerate/earthquakes_type.dart';

class ListAPI {
  ListAPI._();

  static const BmkgApp bmkgApp = BmkgApp._();
  static const RadarBmkg radarBmkg = RadarBmkg._();
  static const InaTews inaTews = InaTews._();
  static const TewsBmkg tewsBmkg = TewsBmkg._();
}

class BmkgApp {
  const BmkgApp._();

  static String bmkgAppDomain = 'https://data.bmkgapp.my.id';
  static String weatherBMKGDomain = 'https://cuaca.bmkg.go.id';
  static String apiAppsBmkgDomain = 'https://api-apps.bmkg.go.id';
  static String apiDevBmkgDomain = 'https://api-app.devbmkg.my.id';

  String get currentCoordinateData => '$apiAppsBmkgDomain/api/df/v1/adm/coord';
  String get currentWeather => '$apiAppsBmkgDomain/api/df/v1/presentwx/adm';

  String get forecasts => '$weatherBMKGDomain/api/df/v1/forecast/adm';

  String get nearestRadar => '$apiAppsBmkgDomain/api/radar';

  String get radar => '$apiAppsBmkgDomain/storage/radar/radar-dev.json';

  String get sateliteImage => '$apiDevBmkgDomain/json/satelit.json';

  String get waterWave =>
      '$apiAppsBmkgDomain/storage/cuaca-maritim/overview/gelombang.json';
}

class InaTews {
  const InaTews._();

  static String inaTewsDomain =
      'https://bmkg-content-inatews.storage.googleapis.com';

  String get lastEarthquakeFelt => '$inaTewsDomain/datagempa.json';

  String get recentEarthquake => '$inaTewsDomain/lastQL.json';

  String get oneWeekEarthquakes => '$inaTewsDomain/gempaQL.json';

  String get earthquakesFelt => '$inaTewsDomain/last30feltevent.xml';

  String get lastEarthquake => '$inaTewsDomain/last30event.xml';

  String get liveEarthquake => '$inaTewsDomain/live30event.xml';

  String get earthquakesTsunami => '$inaTewsDomain/last30tsunamievent.xml';

  String fromEarthquakesType(EarthquakesType type) {
    return [
      earthquakesFelt,
      liveEarthquake,
      lastEarthquake,
      earthquakesTsunami
    ][type.index];
  }
}

class TewsBmkg {
  const TewsBmkg._();

  static String dataBmkgDomain = 'https://data.bmkg.go.id/';

  String get earthquakeFelts =>
      '$dataBmkgDomain/DataMKG/TEWS/gempadirasakan.json';
}

class RadarBmkg {
  const RadarBmkg._();

  static String dataBmkgDomain = 'https://radar.bmkg.go.id';

  String get radarMeta =>
      '$dataBmkgDomain/sidarma-nowcast/data/radarMetadata.json';

  String radar(String id) =>
      '$dataBmkgDomain/sidarma-nowcast/android/ssx$id.json';
}
