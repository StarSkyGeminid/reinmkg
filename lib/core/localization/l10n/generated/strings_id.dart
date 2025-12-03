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
    String _temp0 = intl.Intl.selectLogic(locale, {
      'en': 'English',
      'id': 'Indonesia',
      'other': 'Tidak Diketahui',
    });
    return '$_temp0';
  }

  @override
  String get unitText => 'Satuan';

  @override
  String get unitSelectionTypeText => 'Pilih Satuan';

  @override
  String unitType(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'true': 'Metrik',
      'false': 'Imperial',
      'other': 'Tidak Diketahui',
    });
    return '$_temp0';
  }

  @override
  String get unitMetricExampleText => 'Metrik (°C, kmpj)';

  @override
  String get unitImperialExampleText => 'Imperial (°F, mpj)';

  @override
  String get generalSettingsText => 'Pengaturan';

  @override
  String get waveCategoryCalm => 'Tenang';

  @override
  String get waveCategoryLow => 'Rendah';

  @override
  String get waveCategoryMedium => 'Sedang';

  @override
  String get waveCategoryHigh => 'Tinggi';

  @override
  String get waveCategoryVeryHigh => 'Sangat Tinggi';

  @override
  String get waveCategoryExtreme => 'Ekstrim';

  @override
  String get waveCategoryVeryExtreme => 'Sangat Ekstrim';

  @override
  String waveCategory(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'calm': 'Tenang',
      'low': 'Rendah',
      'medium': 'Sedang',
      'high': 'Tinggi',
      'veryHigh': 'Sangat Tinggi',
      'extreme': 'Ekstrim',
      'veryExtreme': 'Sangat Ekstrim',
      'other': '-',
    });
    return '$_temp0';
  }

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
  String get wtrIsolatedShower => 'Hujan Singkat';

  @override
  String get wtrSevereThunderStorm => 'Badai Petir Berat';

  @override
  String wtrType(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'clearSkies': 'Cerah',
      'partlyCloudy': 'Sebagian Berawan',
      'mostlyCloudy': 'Berawan',
      'overcast': 'Mendung',
      'haze': 'Kabut',
      'smoke': 'Asap',
      'fog': 'Kabut',
      'lightRain': 'Hujan Ringan',
      'rain': 'Hujan',
      'heavyRain': 'Hujan Lebat',
      'isolatedShower': 'Hujan Singkat',
      'severeThunderStorm': 'Badai Petir Berat',
      'other': 'Tidak Diketahui',
    });
    return '$_temp0';
  }

  @override
  String wdirType(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'north': 'Utara',
      'northEast': 'Timur Laut',
      'east': 'Timur',
      'southEast': 'Tenggara',
      'south': 'Selatan',
      'southWest': 'Barat Daya',
      'west': 'Barat',
      'northWest': 'Barat Laut',
      'other': '-',
    });
    return '$_temp0';
  }

  @override
  String get dashboardNowLabel => 'Sekarang';

  @override
  String get forecastWeatherLabel => 'Prakiraan Cuaca';

  @override
  String get dailyForecastLabel => 'Prakiraan Harian';

  @override
  String get radarLabel => 'Radar';

  @override
  String get satelliteLabel => 'Satelit';

  @override
  String get nowcastLabel => 'Nowcast';

  @override
  String get maritimeLabel => 'Maritim';

  @override
  String get earthquakeFeltTitle => 'Dirasakan';

  @override
  String get earthquakeFelt => 'Gempa dirasakan';

  @override
  String get earthquakeRealtime => 'Gempa Terkini';

  @override
  String get realtimeTitle => 'Waktu Nyata';

  @override
  String get earthquakeMagnitude => 'Magnitudo';

  @override
  String get earthquakeDepth => 'Kedalaman';

  @override
  String get earthquakeTime => 'Waktu';

  @override
  String get unitKm => 'Km';

  @override
  String get unitMiles => 'Miles';

  @override
  String get magnitudeUnit => 'SR';

  @override
  String seismicStation(String station) {
    return 'Stasiun: $station';
  }

  @override
  String seismicEpicenter(String value) {
    return 'Epicenter Gempa\n$value';
  }

  @override
  String seismicPga(String value) {
    return 'PGA: $value';
  }

  @override
  String seismicPgv(String value) {
    return 'PGV: $value';
  }

  @override
  String seismicMmi(String value) {
    return 'MMI: $value';
  }

  @override
  String earthquakeFeltInRegency(String regency) {
    return 'Gempa dirasakan di $regency';
  }

  @override
  String weatherAlertIssuedForRegency(String regency) {
    return 'Peringatan dini cuaca untuk $regency telah diterbitkan';
  }

  @override
  String fromSubdistrict(String subdistrict) {
    return 'dari $subdistrict';
  }

  @override
  String get maritimeLoadError => 'Gagal memuat data cuaca maritim';

  @override
  String get maritimeDayLabelToday => 'Hari ini';

  @override
  String maritimeDayLabelHPlus(int n) {
    return 'H+$n';
  }

  @override
  String get noDetailsAvailable => 'Tidak ada detail tersedia';

  @override
  String validFromTo(String from, String to) {
    return 'Berlaku mulai $from\nhingga $to';
  }

  @override
  String get humidityLabel => 'Kelembapan';

  @override
  String get windDirectionLabel => 'Arah Angin';

  @override
  String get windLabel => 'Angin';

  @override
  String get earthquakeFeltAreaLabel => 'Daerah Terasa';

  @override
  String get coordinateLabel => 'Koordinat';

  @override
  String get descriptionLabel => 'Deskripsi';

  @override
  String get instructionLabel => 'Instruksi';

  @override
  String get distanceLabel => 'Jarak';

  @override
  String get legendLabel => 'Legenda';

  @override
  String get eventIdNotAvailable => 'ID kejadian tidak tersedia';

  @override
  String get tsunamiLabel => 'Tsunami';

  @override
  String get tsunamiWarningZonesLabel => 'Zona Peringatan';

  @override
  String get tsunamiWarningInfoAvailable => 'Informasi peringatan tersedia';

  @override
  String get tsunamiNoWarningData => 'Tidak ada data peringatan tsunami';

  @override
  String eqType(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'felt': 'Dirasakan',
      'realtime': 'Terkini',
      'overFive': 'M > 5',
      'tsunami': 'Tsunami',
      'other': 'Tidak diketahui',
    });
    return '$_temp0';
  }

  @override
  String get showLessLabel => 'Tampilkan lebih sedikit';

  @override
  String showMoreCount(int count) {
    return 'Tampilkan $count lagi';
  }

  @override
  String get mapLabelWZ => 'Peta WZ';

  @override
  String get mapLabelTT => 'Peta TT';

  @override
  String get mapLabelSSM => 'Peta SSM';

  @override
  String get warningPrefix => 'Peringatan';

  @override
  String get licensesSectionTitle => 'Lisensi';

  @override
  String get appLicenseTitle => 'Lisensi Aplikasi';

  @override
  String get opensourceLicenseTitle => 'Lisensi Opensource';

  @override
  String get mapTileAttribution =>
      'Esri, HERE, Garmin, (c) OpenStreetMap contributors, and the GIS user community';

  @override
  String get celestialDataLabel => 'Data Benda Langit';

  @override
  String get sunLabel => 'Matahari';

  @override
  String get sunriseLabel => 'Terbit Matahari';

  @override
  String get sunsetLabel => 'Terbenam Matahari';

  @override
  String get moonLabel => 'Bulan';

  @override
  String get moonriseLabel => 'Terbit Bulan';

  @override
  String get moonsetLabel => 'Terbenam Bulan';

  @override
  String get notAvailableLabel => 'Tidak tersedia';

  @override
  String get moonPhaseNew => 'Bulan Baru';

  @override
  String get moonPhaseWaxingCrescent => 'Bulan Sabit Meningkat';

  @override
  String get moonPhaseFirstQuarter => 'Kuartal Pertama';

  @override
  String get moonPhaseWaxingGibbous => 'Bulan Cembung Meningkat';

  @override
  String get moonPhaseFullMoon => 'Bulan Purnama';

  @override
  String get moonPhaseWaningGibbous => 'Bulan Cembung Menurun';

  @override
  String get moonPhaseLastQuarter => 'Kuartal Terakhir';

  @override
  String get moonPhaseWaningCrescent => 'Bulan Sabit Menurun';

  @override
  String moonPhaseIlluminatedPercent(int percent) {
    return '$percent% Terang';
  }

  @override
  String get unitMeter => 'm';

  @override
  String get unitFeet => 'ft';

  @override
  String get dash => '-';

  @override
  String get emdash => '—';

  @override
  String get validFrom => 'Berlaku Mulai';

  @override
  String get validUntil => 'Berlaku Hingga';

  @override
  String get affectedDistricts => 'Area Terdampak';

  @override
  String get spreadDistricts => 'Area Sebaran';

  @override
  String get event => 'Peristiwa';

  @override
  String get severity => 'Tingkat Keparahan';

  @override
  String get category => 'Kategori';

  @override
  String get tags => 'Tag';

  @override
  String get source => 'Sumber';
}
