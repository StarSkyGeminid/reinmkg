// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'strings.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class StringsEn extends Strings {
  StringsEn([String locale = 'en']) : super(locale);

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get idText => 'Indonesian';

  @override
  String get enText => 'English';

  @override
  String get languageText => 'Language';

  @override
  String get languageSelectionText => 'Select Language';

  @override
  String languageFromLocale(String locale) {
    String _temp0 = intl.Intl.selectLogic(locale, {
      'en': 'English',
      'id': 'Indonesia',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get unitText => 'Unit';

  @override
  String get unitSelectionTypeText => 'Select Unit';

  @override
  String unitType(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'true': 'Metric',
      'false': 'Imperial',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get unitMetricExampleText => 'Metric (°C, kmph)';

  @override
  String get unitImperialExampleText => 'Imperial (°F, mph)';

  @override
  String get generalSettingsText => 'General Settings';

  @override
  String get waveCategoryCalm => 'Calm';

  @override
  String get waveCategoryLow => 'Low';

  @override
  String get waveCategoryMedium => 'Moderate';

  @override
  String get waveCategoryHigh => 'High';

  @override
  String get waveCategoryVeryHigh => 'Very High';

  @override
  String get waveCategoryExtreme => 'Extreme';

  @override
  String get waveCategoryVeryExtreme => 'Very Extreme';

  @override
  String waveCategory(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'calm': 'Calm',
      'low': 'Low',
      'medium': 'Moderate',
      'high': 'High',
      'veryHigh': 'Very High',
      'extreme': 'Extreme',
      'veryExtreme': 'Very Extreme',
      'other': '-',
    });
    return '$_temp0';
  }

  @override
  String get wtrClearSkies => 'Clear Sky';

  @override
  String get wtrPartlyCloudy => 'Partly Cloudy';

  @override
  String get wtrMostlyCloudy => 'Mostly Cloudy';

  @override
  String get wtrOvercast => 'Overcast';

  @override
  String get wtrHaze => 'Haze';

  @override
  String get wtrSmoke => 'Smoke';

  @override
  String get wtrFog => 'Fog';

  @override
  String get wtrLightRain => 'Light Rain';

  @override
  String get wtrRain => 'Rain';

  @override
  String get wtrHeavyRain => 'Heavy Rain';

  @override
  String get wtrIsolatedShower => 'Isolated Shower';

  @override
  String get wtrSevereThunderStorm => 'Severe Thunder Storm';

  @override
  String wtrType(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'clearSkies': 'Clear Sky',
      'partlyCloudy': 'Partly Cloudy',
      'mostlyCloudy': 'Mostly Cloudy',
      'overcast': 'Overcast',
      'haze': 'Haze',
      'smoke': 'Smoke',
      'fog': 'Fog',
      'lightRain': 'Light Rain',
      'rain': 'Rain',
      'heavyRain': 'Heavy Rain',
      'isolatedShower': 'Isolated Shower',
      'severeThunderStorm': 'Severe Thunder Storm',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String wdirType(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'north': 'North',
      'northEast': 'North East',
      'east': 'East',
      'southEast': 'South East',
      'south': 'South',
      'southWest': 'South West',
      'west': 'West',
      'northWest': 'North West',
      'other': '-',
    });
    return '$_temp0';
  }

  @override
  String get dashboardNowLabel => 'Now';

  @override
  String get forecastWeatherLabel => 'Weather Forecast';

  @override
  String get dailyForecastLabel => 'Daily Forecast';

  @override
  String get radarLabel => 'Radar';

  @override
  String get satelliteLabel => 'Satellite';

  @override
  String get nowcastLabel => 'Nowcast';

  @override
  String get maritimeLabel => 'Maritime';

  @override
  String get earthquakeFeltTitle => 'Felt';

  @override
  String get earthquakeFelt => 'Earthquake felt';

  @override
  String get earthquakeRealtime => 'Realtime Earthquake';

  @override
  String get realtimeTitle => 'Realtime';

  @override
  String get earthquakeMagnitude => 'Magnitude';

  @override
  String get earthquakeDepth => 'Depth';

  @override
  String get earthquakeTime => 'Time';

  @override
  String get unitKm => 'km';

  @override
  String get unitMiles => 'miles';

  @override
  String get magnitudeUnit => 'SR';

  @override
  String seismicStation(String station) {
    return 'Station: $station';
  }

  @override
  String seismicEpicenter(String value) {
    return 'Earthquake Epicenter\n$value';
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
    return 'Earthquake felt in $regency';
  }

  @override
  String weatherAlertIssuedForRegency(String regency) {
    return 'Early weather alert for $regency has been issued';
  }

  @override
  String fromSubdistrict(String subdistrict) {
    return 'from $subdistrict';
  }

  @override
  String get maritimeLoadError => 'Failed to load maritime weather data';

  @override
  String get maritimeDayLabelToday => 'Today';

  @override
  String maritimeDayLabelHPlus(int n) {
    return 'H+$n';
  }

  @override
  String get noDetailsAvailable => 'No details available';

  @override
  String validFromTo(String from, String to) {
    return 'Valid from $from\nuntil $to';
  }

  @override
  String get humidityLabel => 'Humidity';

  @override
  String get windDirectionLabel => 'Wind Direction';

  @override
  String get windLabel => 'Wind';

  @override
  String get earthquakeFeltAreaLabel => 'Felt Area';

  @override
  String get coordinateLabel => 'Coordinate';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get instructionLabel => 'Instruction';

  @override
  String get distanceLabel => 'Distance';

  @override
  String get legendLabel => 'Legend';

  @override
  String get eventIdNotAvailable => 'Event id not available';

  @override
  String get tsunamiLabel => 'Tsunami';

  @override
  String get tsunamiWarningZonesLabel => 'Warning Zones';

  @override
  String get tsunamiWarningInfoAvailable => 'Warning information available';

  @override
  String get tsunamiNoWarningData => 'No tsunami warning data';

  @override
  String eqType(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'felt': 'Felt',
      'realtime': 'Realtime',
      'overFive': 'M > 5',
      'tsunami': 'Tsunami',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get showLessLabel => 'Show less';

  @override
  String showMoreCount(int count) {
    return 'Show $count more';
  }

  @override
  String get mapLabelWZ => 'WZ Map';

  @override
  String get mapLabelTT => 'TT Map';

  @override
  String get mapLabelSSM => 'SSM Map';

  @override
  String get warningPrefix => 'Warning';

  @override
  String get licensesSectionTitle => 'Licenses';

  @override
  String get appLicenseTitle => 'App License';

  @override
  String get opensourceLicenseTitle => 'Open-source Licenses';

  @override
  String get mapTileAttribution =>
      'Esri, HERE, Garmin, (c) OpenStreetMap contributors, and the GIS user community';

  @override
  String get celestialDataLabel => 'Celestial Data';

  @override
  String get sunLabel => 'Sun';

  @override
  String get sunriseLabel => 'Sunrise';

  @override
  String get sunsetLabel => 'Sunset';

  @override
  String get moonLabel => 'Moon';

  @override
  String get moonriseLabel => 'Moonrise';

  @override
  String get moonsetLabel => 'Moonset';

  @override
  String get notAvailableLabel => 'Not available';

  @override
  String get moonPhaseNew => 'New Moon';

  @override
  String get moonPhaseWaxingCrescent => 'Waxing Crescent';

  @override
  String get moonPhaseFirstQuarter => 'First Quarter';

  @override
  String get moonPhaseWaxingGibbous => 'Waxing Gibbous';

  @override
  String get moonPhaseFullMoon => 'Full Moon';

  @override
  String get moonPhaseWaningGibbous => 'Waning Gibbous';

  @override
  String get moonPhaseLastQuarter => 'Last Quarter';

  @override
  String get moonPhaseWaningCrescent => 'Waning Crescent';

  @override
  String moonPhaseIlluminatedPercent(int percent) {
    return '$percent% Illuminated';
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
  String get validFrom => 'Valid From';

  @override
  String get validUntil => 'Valid Until';

  @override
  String get affectedDistricts => 'Affected Area';

  @override
  String get spreadDistricts => 'Spread Area';

  @override
  String get event => 'Event';

  @override
  String get severity => 'Severity';

  @override
  String get category => 'Category';

  @override
  String get tags => 'Tags';

  @override
  String get source => 'Source';
}
