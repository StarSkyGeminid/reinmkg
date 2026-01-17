class ApiEndpoints {
  ApiEndpoints._();

  static const BmkgApp bmkgApp = BmkgApp._();
  static const SidarmaBmkg sidarma = SidarmaBmkg._();
  static const InaTews inaTews = InaTews._();
  static const TewsBmkg tewsBmkg = TewsBmkg._();
}

class BmkgApp {
  const BmkgApp._();

  static String apiAppsBmkgDomain = 'https://api-apps.bmkg.go.id';

  String get nearestLocation => '$apiAppsBmkgDomain/api/df/v1/adm/coord';
  String get currentWeather => '$apiAppsBmkgDomain/api/df/v1/presentwx/adm';

  String get forecasts => '$apiAppsBmkgDomain/api/df/v1/forecast/adm';

  String get nearestRadar => '$apiAppsBmkgDomain/api/radar';

  String get radar => '$apiAppsBmkgDomain/storage/radar/radar-dev.json';

  String get sateliteImage => '$apiAppsBmkgDomain/json/satelit.json';

  String get waterWave =>
      '$apiAppsBmkgDomain/storage/cuaca-maritim/overview/gelombang.json';

  String get nowcast => '$apiAppsBmkgDomain/api/warningcuaca';

  String maritimeWeather(String areaId) =>
      '$apiAppsBmkgDomain/storage/cuaca-maritim/data/$areaId.json';
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

  String earthquakePga(String eventId) =>
      '$inaTewsDomain/simap/event_$eventId.json';
}

class TewsBmkg {
  const TewsBmkg._();

  static String dataBmkgDomain = 'https://data.bmkg.go.id/';

  String get earthquakeFelts =>
      '$dataBmkgDomain/DataMKG/TEWS/gempadirasakan.json';
}

class SidarmaBmkg {
  const SidarmaBmkg._();

  static String dataBmkgDomain = 'https://api.bmkg.go.id';

  String get radarMeta =>
      '$dataBmkgDomain/radar/radarlist';

  String radar(String id) =>
      '$dataBmkgDomain/sidarma/sidarma-nowcast/android/ssx$id.json';
}
