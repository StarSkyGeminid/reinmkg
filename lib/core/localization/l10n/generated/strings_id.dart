// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'strings.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class StringsId extends Strings {
  StringsId([String locale = 'id']) : super(locale);

  @override
  String version(String version) {
    return 'Versi $version';
  }

  @override
  String get idText => 'Indonesia';

  @override
  String get enText => 'Inggris';

  @override
  String get languageText => 'Bahasa';

  @override
  String get languageSelectionText => 'Pilih Bahasa';

  @override
  String languageFromLocale(String locale) {
    String _temp0 = intl.Intl.selectLogic(
      locale,
      {
        'en': 'English',
        'id': 'Indonesia',
        'other': 'Tidak Diketahui',
      },
    );
    return '$_temp0';
  }

  @override
  String get unitText => 'Satuan';

  @override
  String get unitSelectionTypeText => 'Pilih Satuan';

  @override
  String unitType(String unit) {
    String _temp0 = intl.Intl.selectLogic(
      unit,
      {
        'metric': 'Metrik',
        'imperial': 'Imperial',
        'other': 'Tidak Diketahui',
      },
    );
    return '$_temp0';
  }

  @override
  String get unitMetricExampleText => 'Metrik (°C, kmpj)';

  @override
  String get unitImperialExampleText => 'Imperial (°F, mpj)';

  @override
  String get generalSettingsText => 'Pengaturan';

  @override
  String get wtrClearSkies => 'Cerah';

  @override
  String get wtrPartlyCloudy => 'Sebagian Berawan';

  @override
  String get wtrMostlyCloudy => 'Berawan';

  @override
  String get wtrOvercast => 'Mendung';

  @override
  String get wtrHaze => 'Kabut';

  @override
  String get wtrSmoke => 'Asap';

  @override
  String get wtrFog => 'Kabut';

  @override
  String get wtrLightRain => 'Hujan Ringan';

  @override
  String get wtrRain => 'Hujan';

  @override
  String get wtrHeavyRain => 'Hujan Lebat';

  @override
  String get wtrIsolatedShower => 'Hujan Lokal';

  @override
  String get wtrSevereThunderStorm => 'Badai Guntur yang Parah';

  @override
  String get now => 'Hari ini';

  @override
  String get humidity => 'Humiditas';

  @override
  String get windSpeed => 'Angin';

  @override
  String get windDirection => 'Arah Angin';

  @override
  String get weatherForecast => 'Prakiraan Cuaca';

  @override
  String get glossariumText => 'Glosarium';

  @override
  String get weatherText => 'Cuaca';

  @override
  String get sateliteText => 'Satelit';

  @override
  String get earthquakeText => 'Gempa Bumi';

  @override
  String get weatherGlosariumTitle => 'Glosari Cuaca';

  @override
  String get weatherIconDescriptionTitle => 'Keterangan Ikon Cuaca';

  @override
  String get weatherClearDescription => 'Langit tidak tertutup awan atau bagian langit yang tertutup awan hanya 1 oktas¹.';

  @override
  String get weatherPartlyCloudyDescription => 'Langit yang tertutup awan antara 2-3 oktas¹.';

  @override
  String get weatherMostlyCloudyDescription => 'Langit yang tertutup awan antara 4-6 oktas¹.';

  @override
  String get weatherOvercastDescription => 'Langit yang tertutup awan antara 7-8 oktas¹.';

  @override
  String get weatherHazeDescription => 'Reduksi jarak pandang akibat partikel halus seperti debu atau polusi yang menggantung di udara.';

  @override
  String get weatherSmokeDescription => 'Partikel debu, asap, atau gas berbahaya yang menciptakan lapisan udara tebal dan berbahaya di dekat permukaan tanah.';

  @override
  String get weatherFogDescription => 'Uap air yang berada dekat permukaan tanah berkondensasi dan menjadi mirip awan.';

  @override
  String get weatherLightRainDescription => 'Hujan dengan akumulasi curah hujan antara 20-50 mm/hari atau 5-20 mm/jam.';

  @override
  String get weatherRainDescription => 'Hujan dengan akumulasi curah hujan antara 5-20 mm/hari atau 0.1-5 mm/jam.';

  @override
  String get weatherHeavyRainDescription => 'Hujan dengan akumulasi curah hujan >50 mm/hari atau >20 mm/jam.';

  @override
  String get weatherIsolatedShowerDescription => 'Hujan ringan hingga sedang yang turun secara sporadis di lokasi tertentu, dengan cakupan wilayah kecil dan sering tidak berlangsung lama.';

  @override
  String get weatherSevereThunderStormDescription => 'Hujan yang disertai kilat/petir dan angin kencang.';

  @override
  String get aboutOctas => '[1] Oktas merupakan satuan dalam pengukuran untuk mendeskripsikan jumlah awan yang menutupi langit pada suatu lokasi.';

  @override
  String get windIconDescriptionTitle => 'Keterangan Ikon Arah Angin';

  @override
  String get windDirectionNorthDescription => 'Arah Angin dari Utara (U)';

  @override
  String get windDirectionNorthEastDescription => 'Arah Angin dari Timur Laut (TL)';

  @override
  String get windDirectionEastDescription => 'Arah Angin dari Timur (T)';

  @override
  String get windDirectionSouthEastDescription => 'Arah Angin dari Tenggara (TG)';

  @override
  String get windDirectionSouthDescription => 'Arah Angin dari Selatan (S)';

  @override
  String get windDirectionSouthWestDescription => 'Arah Angin dari Barat Daya (BD)';

  @override
  String get windDirectionWestDescription => 'Arah Angin dari Barat (B)';

  @override
  String get windDirectionNorthWestDescription => 'Arah Angin dari Barat Laut (BL)';

  @override
  String get oneWeekForecast => 'Cuaca Sepekan Kedepan';

  @override
  String get radar => 'Radar';

  @override
  String radarTypeName(String metric, String value) {
    String _temp0 = intl.Intl.selectLogic(
      metric,
      {
        'metric': 'CAPPI 0.5Km',
        'other': 'CAPPI 0.31mil',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      metric,
      {
        'metric': 'CAPPI 0.5Km',
        'other': 'CAPPI 0.32mil',
      },
    );
    String _temp2 = intl.Intl.selectLogic(
      value,
      {
        'cmax': 'CMAX',
        'nowcast': 'NOWCAST',
        'qpf': 'QPF',
        'cmaxssa': 'CMAX-SSA',
        'cmaxhwind': 'CMAX-HWIND',
        'cappi05': '$_temp0 ',
        'cappi1': '$_temp1',
        'sri': 'SRI',
        'pac1': 'PAC 1jam',
        'pac6': 'PAC 6jam',
        'pac12': 'PAC 12jam',
        'pac24': 'PAC 24jam',
        'other': 'Unknown',
      },
    );
    return '$_temp2';
  }

  @override
  String get sateliteImage => 'Citra Satelit';

  @override
  String get nowcast => 'Nowcast';

  @override
  String get maritime => 'Maritim';

  @override
  String windDirectionValue(String value) {
    String _temp0 = intl.Intl.selectLogic(
      value,
      {
        'north': 'U',
        'northEast': 'TL',
        'east': 'T',
        'southEast': 'TG',
        'south': 'S',
        'southWest': 'BD',
        'west': 'B',
        'northWest': 'BL',
        'other': '$value',
      },
    );
    return '$_temp0';
  }

  @override
  String windDirectionDescription(String direction) {
    String _temp0 = intl.Intl.selectLogic(
      direction,
      {
        'north': 'Utara',
        'northEast': 'Timur Laut',
        'east': 'Timur',
        'southEast': 'Tenggara',
        'south': 'Selatan',
        'southWest': 'Barat Daya',
        'west': 'Barat',
        'northWest': 'Barat Laut',
        'other': '$direction',
      },
    );
    return 'Arah Angin dari $_temp0';
  }

  @override
  String speedWithUnit(String metric, String nan, num value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    String _temp0 = intl.Intl.selectLogic(
      nan,
      {
        'nan': '- kmpj',
        'other': '$valueString kmpj',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      nan,
      {
        'nan': '- mpj',
        'other': '$valueString\nmpj',
      },
    );
    String _temp2 = intl.Intl.selectLogic(
      metric,
      {
        'true': '$_temp0',
        'other': '$_temp1',
      },
    );
    return '$_temp2';
  }

  @override
  String distanceWithUnit(String metric, String nan, num value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    String _temp0 = intl.Intl.selectLogic(
      nan,
      {
        'nan': '- km',
        'other': '$valueString km',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      nan,
      {
        'nan': '- mil',
        'other': '$valueString mil',
      },
    );
    String _temp2 = intl.Intl.selectLogic(
      metric,
      {
        'true': '$_temp0',
        'other': '$_temp1',
      },
    );
    return '$_temp2';
  }

  @override
  String get eqFelt => 'Gempa Dirasakan';

  @override
  String get eqRealtime => 'Gempa Terkini';

  @override
  String get eqMagnitude => 'Magnitudo';

  @override
  String get eqDepth => 'Kedalaman';

  @override
  String get eqFeltArea => 'Wilayah Dirasakan';

  @override
  String tsunamiEarlyWarning(String value) {
    return 'Peringatan Dini $value';
  }

  @override
  String get instruction => 'Instruksi';

  @override
  String get coordinate => 'Koordinat';

  @override
  String get description => 'Deksripsi';

  @override
  String get distance => 'Jarak';

  @override
  String get time => 'Waktu';

  @override
  String get showShakeMap => 'Tampilkan ShakeMap';

  @override
  String get hideShakeMap => 'Sembunyikan ShakeMap';

  @override
  String eqWarning(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'felt': 'Gempa Dirasakan',
        'mover5': 'Gempa M>5',
        'pd1': 'Tsunami PD-1',
        'pd2': 'Tsunami PD-2',
        'pd3': 'Tsunami PD-3',
        'pd4': 'Tsunami PD-4',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String eqMenuType(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'map': 'Peta',
        'felt': 'Dirasakan',
        'realtime': 'Terkini',
        'overfive': 'M > 5',
        'tsunami': 'Tsunami',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String eqDistance(String nan, String metric, String location, num distance) {
    String _temp0 = intl.Intl.selectLogic(
      metric,
      {
        'true': 'km',
        'other': 'mil',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      location,
      {
        'null': '-',
        'other': '$location',
      },
    );
    String _temp2 = intl.Intl.selectLogic(
      nan,
      {
        'null': '-',
        'other': '$distance $_temp0 dari lokasi Anda ($_temp1',
      },
    );
    return '$_temp2';
  }

  @override
  String get legend => 'Legenda';

  @override
  String get rainIntensity => 'Intensitas Hujan';

  @override
  String get rainLight => 'Ringan';

  @override
  String get rainModerate => 'Sedang';

  @override
  String get rainHeavy => 'Lebat';

  @override
  String get rainVeryHeavy => 'Sangat Lebat';

  @override
  String get hour => 'Jam';

  @override
  String waveHeightStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'calm': 'Tenang',
        'low': 'Rendah',
        'medium': 'Sedang',
        'high': 'Tinggi',
        'veryhigh': 'Sangat Tinggi',
        'extreme': 'Ekstrim',
        'veryextreme': 'Sangat Ekstrim',
        'other': 'Unkown',
      },
    );
    return '$_temp0';
  }

  @override
  String illumination(double value) {
    final intl.NumberFormat valueNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String valueString = valueNumberFormat.format(value);

    return 'Bercahaya $valueString%';
  }

  @override
  String get riseSetText => 'Terbit - Terbenam';

  @override
  String get sunText => 'Matahari';

  @override
  String get sunriseText => 'Terbit';

  @override
  String get sunsetText => 'Tenggelam';

  @override
  String get moonText => 'Bulan';

  @override
  String get moonriseText => 'Terbit';

  @override
  String get moonsetText => 'Tenggelam';

  @override
  String moonphaseText(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'newMoon': 'Bulan Baru',
        'waxingCrescent': 'Bulan Sabit',
        'firstQuarter': 'Perbani Awal',
        'waxingGibbous': 'Cembung',
        'fullMoon': 'Purnama',
        'waningGibbous': 'Cembung',
        'lastQuarter': 'Perbani Akhir',
        'waningCrescent': 'Bulan Sabit',
        'other': 'Unkown',
      },
    );
    return '$_temp0';
  }
}
