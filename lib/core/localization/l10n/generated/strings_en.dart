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
    String _temp0 = intl.Intl.selectLogic(
      locale,
      {
        'en': 'English',
        'id': 'Indonesia',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String get unitText => 'Unit';

  @override
  String get unitSelectionTypeText => 'Select Unit';

  @override
  String unitType(String unit) {
    String _temp0 = intl.Intl.selectLogic(
      unit,
      {
        'metric': 'Metric',
        'imperial': 'Imperial',
        'other': 'Unknown',
      },
    );
    return '$_temp0';
  }

  @override
  String get unitMetricExampleText => 'Metric (°C, kmph)';

  @override
  String get unitImperialExampleText => 'Imperial (°F, mph)';

  @override
  String get generalSettingsText => 'General Settings';

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
  String get now => 'Today';

  @override
  String get humidity => 'Humidity';

  @override
  String get windSpeed => 'Wind';

  @override
  String get windDirection => 'Wind Direction';

  @override
  String get weatherForecast => 'Weather Forecast';

  @override
  String get glossariumText => 'Glossary';

  @override
  String get weatherText => 'Weather';

  @override
  String get sateliteText => 'Satelite';

  @override
  String get earthquakeText => 'Earthquake';

  @override
  String get weatherGlosariumTitle => 'Weather Glossary';

  @override
  String get weatherIconDescriptionTitle => 'Weather Icon Description';

  @override
  String get weatherClearDescription => 'The sky is not covered by clouds or the part of the sky covered by clouds is only 1 okta¹.';

  @override
  String get weatherPartlyCloudyDescription => 'Cloud-covered sky between 2-3 okta¹.';

  @override
  String get weatherMostlyCloudyDescription => 'Cloud-covered sky between 4-6 okta¹.';

  @override
  String get weatherOvercastDescription => 'Cloud-covered sky between 7-8 okta¹.';

  @override
  String get weatherHazeDescription => 'Reduced visibility due to fine particles such as dust or pollution suspended in the air.';

  @override
  String get weatherSmokeDescription => 'Dust particles, smoke or harmful gases that create a thick and hazardous layer of air near the ground.';

  @override
  String get weatherFogDescription => 'Water vapor near the ground condenses and becomes cloud-like.';

  @override
  String get weatherLightRainDescription => 'Rain with rainfall accumulation between 5-20 mm/day or 0.1-5 mm/hour.';

  @override
  String get weatherRainDescription => 'Rain with rainfall accumulation between 20-50 mm/day or 5-20 mm/hour.';

  @override
  String get weatherHeavyRainDescription => 'Rain with rainfall accumulation >50 mm/day or >20 mm/hour.';

  @override
  String get weatherIsolatedShowerDescription => 'Light to moderate rain that falls sporadically in certain locations, with a small area coverage and often does not last long.';

  @override
  String get weatherSevereThunderStormDescription => 'Rain accompanied by lightning/thunder and strong winds.';

  @override
  String get aboutOctas => '[1] Okta is a unit of measurement used to describe the amount of clouds covering the sky at a given location.';

  @override
  String get windIconDescriptionTitle => 'Wind Direction Icon Description';

  @override
  String get windDirectionNorthDescription => 'Wind Direction from the North (N)';

  @override
  String get windDirectionNorthEastDescription => 'Wind Direction from the Northeast (NE)';

  @override
  String get windDirectionEastDescription => 'Wind Direction from the East (E)';

  @override
  String get windDirectionSouthEastDescription => 'Wind Direction from Southeast (SE)';

  @override
  String get windDirectionSouthDescription => 'Wind Direction from South (S)';

  @override
  String get windDirectionSouthWestDescription => 'Wind Direction from Southwest (SW)';

  @override
  String get windDirectionWestDescription => 'Wind Direction from the West (W)';

  @override
  String get windDirectionNorthWestDescription => 'Wind Direction from Northwest (NW)';

  @override
  String get oneWeekForecast => 'Weekly Forecast';

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
        'pac1': 'PAC 1h',
        'pac6': 'PAC 6h',
        'pac12': 'PAC 12h',
        'pac24': 'PAC 24h',
        'other': 'Unknown',
      },
    );
    return '$_temp2';
  }

  @override
  String get sateliteImage => 'Satelite';

  @override
  String get nowcast => 'Nowcast';

  @override
  String get maritime => 'Maritime';

  @override
  String windDirectionValue(String value) {
    String _temp0 = intl.Intl.selectLogic(
      value,
      {
        'north': 'N',
        'northEast': 'NE',
        'east': 'E',
        'southEast': 'SE',
        'south': 'S',
        'southWest': 'SW',
        'west': 'W',
        'northWest': 'NW',
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
        'north': 'North',
        'northEast': 'North East',
        'east': 'East',
        'southEast': 'South East',
        'south': 'South',
        'southWest': 'South West',
        'west': 'West',
        'northWest': 'North West',
        'other': '$direction',
      },
    );
    return 'Wind direction from the $_temp0';
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
        'nan': '- kmph',
        'other': '$valueString kmph',
      },
    );
    String _temp1 = intl.Intl.selectLogic(
      nan,
      {
        'nan': '- mph',
        'other': '$valueString\nmph',
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
    String _temp1 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$valueString miles',
      one: '1 mile',
      zero: '0 mile',
    );
    String _temp2 = intl.Intl.selectLogic(
      nan,
      {
        'nan': '- mile',
        'other': '$_temp1',
      },
    );
    String _temp3 = intl.Intl.selectLogic(
      metric,
      {
        'true': '$_temp0',
        'other': '$_temp2',
      },
    );
    return '$_temp3';
  }

  @override
  String get eqFelt => 'Earthquake Felt';

  @override
  String get eqRealtime => 'Earthquake Realtime';

  @override
  String get eqMagnitude => 'Magnitude';

  @override
  String get eqDepth => 'Depth';

  @override
  String get eqFeltArea => 'Felt Area';

  @override
  String tsunamiEarlyWarning(String value) {
    return 'Early Warning $value';
  }

  @override
  String get instruction => 'Instruction';

  @override
  String get coordinate => 'Coordinate';

  @override
  String get description => 'Description';

  @override
  String get distance => 'Distance';

  @override
  String get time => 'Time';

  @override
  String get showShakeMap => 'Show ShakeMap';

  @override
  String get hideShakeMap => 'Hide ShakeMap';

  @override
  String eqWarning(String type) {
    String _temp0 = intl.Intl.selectLogic(
      type,
      {
        'felt': 'Earthquake Felt',
        'mover5': 'M>5 Earthquake',
        'pd1': 'Tsunami EW-1',
        'pd2': 'Tsunami EW-2',
        'pd3': 'Tsunami EW-3',
        'pd4': 'Tsunami EW-4',
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
        'map': 'Map',
        'felt': 'Felt',
        'realtime': 'Newest',
        'overfive': 'M > 5',
        'tsunami': 'Tsunami',
        'other': '-',
      },
    );
    return '$_temp0';
  }

  @override
  String eqDistance(String nan, String metric, String location, num distance) {
    final intl.NumberFormat distanceNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String distanceString = distanceNumberFormat.format(distance);

    String _temp0 = intl.Intl.pluralLogic(
      distance,
      locale: localeName,
      other: 'miles',
      one: 'mile',
      zero: 'mile',
    );
    String _temp1 = intl.Intl.selectLogic(
      nan,
      {
        'nan': '- mile',
        'other': '$_temp0',
      },
    );
    String _temp2 = intl.Intl.selectLogic(
      metric,
      {
        'true': 'km',
        'other': '$_temp1',
      },
    );
    String _temp3 = intl.Intl.selectLogic(
      location,
      {
        'null': '-',
        'other': '$location',
      },
    );
    String _temp4 = intl.Intl.selectLogic(
      nan,
      {
        'nan': '-',
        'other': '$distanceString $_temp2 from your location ($_temp3)',
      },
    );
    return '$_temp4';
  }

  @override
  String get legend => 'Legend';

  @override
  String get rainIntensity => 'Rain Intensity';

  @override
  String get rainLight => 'Light';

  @override
  String get rainModerate => 'Moderate';

  @override
  String get rainHeavy => 'Heavy';

  @override
  String get rainVeryHeavy => 'Very Heavy';

  @override
  String get hour => 'Hour';

  @override
  String waveHeightStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'calm': 'Calm',
        'low': 'Low',
        'medium': 'Medium',
        'high': 'High',
        'veryhigh': 'Very Heigh',
        'extreme': 'Extreme',
        'veryextreme': 'Very Extreme',
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

    return '$valueString% Illuminated';
  }

  @override
  String get riseSetText => 'Rise - Set';

  @override
  String get sunText => 'Sun';

  @override
  String get sunriseText => 'Sunrise';

  @override
  String get sunsetText => 'Sunset';

  @override
  String get moonText => 'Moon';

  @override
  String get moonriseText => 'Moonrise';

  @override
  String get moonsetText => 'Moonset';

  @override
  String moonphaseText(String status) {
    String _temp0 = intl.Intl.selectLogic(
      status,
      {
        'newMoon': 'New Moon',
        'waxingCrescent': 'Waxing Crescent',
        'firstQuarter': 'First Quarter',
        'waxingGibbous': 'Waxing Gibbous',
        'fullMoon': 'Full Moon',
        'waningGibbous': 'Waning Gibbous',
        'lastQuarter': 'Last Quarter',
        'waningCrescent': 'Waning Crescent',
        'other': 'Unkown',
      },
    );
    return '$_temp0';
  }
}
