import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'strings_en.dart';
import 'strings_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Strings
/// returned by `Strings.of(context)`.
///
/// Applications need to include `Strings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Strings.localizationsDelegates,
///   supportedLocales: Strings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Strings.supportedLocales
/// property.
abstract class Strings {
  Strings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings)!;
  }

  static const LocalizationsDelegate<Strings> delegate = _StringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @idText.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get idText;

  /// No description provided for @enText.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get enText;

  /// No description provided for @languageText.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageText;

  /// No description provided for @languageSelectionText.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageSelectionText;

  /// No description provided for @languageFromLocale.
  ///
  /// In en, this message translates to:
  /// **'{locale, select, en{English} id{Indonesia} other{Unknown}}'**
  String languageFromLocale(String locale);

  /// No description provided for @unitText.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unitText;

  /// No description provided for @unitSelectionTypeText.
  ///
  /// In en, this message translates to:
  /// **'Select Unit'**
  String get unitSelectionTypeText;

  /// No description provided for @unitType.
  ///
  /// In en, this message translates to:
  /// **'{unit, select, metric{Metric} imperial{Imperial} other{Unknown}}'**
  String unitType(String unit);

  /// No description provided for @unitMetricExampleText.
  ///
  /// In en, this message translates to:
  /// **'Metric (°C, kmph)'**
  String get unitMetricExampleText;

  /// No description provided for @unitImperialExampleText.
  ///
  /// In en, this message translates to:
  /// **'Imperial (°F, mph)'**
  String get unitImperialExampleText;

  /// No description provided for @generalSettingsText.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettingsText;

  /// No description provided for @wtrClearSkies.
  ///
  /// In en, this message translates to:
  /// **'Clear Sky'**
  String get wtrClearSkies;

  /// No description provided for @wtrPartlyCloudy.
  ///
  /// In en, this message translates to:
  /// **'Partly Cloudy'**
  String get wtrPartlyCloudy;

  /// No description provided for @wtrMostlyCloudy.
  ///
  /// In en, this message translates to:
  /// **'Mostly Cloudy'**
  String get wtrMostlyCloudy;

  /// No description provided for @wtrOvercast.
  ///
  /// In en, this message translates to:
  /// **'Overcast'**
  String get wtrOvercast;

  /// No description provided for @wtrHaze.
  ///
  /// In en, this message translates to:
  /// **'Haze'**
  String get wtrHaze;

  /// No description provided for @wtrSmoke.
  ///
  /// In en, this message translates to:
  /// **'Smoke'**
  String get wtrSmoke;

  /// No description provided for @wtrFog.
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get wtrFog;

  /// No description provided for @wtrLightRain.
  ///
  /// In en, this message translates to:
  /// **'Light Rain'**
  String get wtrLightRain;

  /// No description provided for @wtrRain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get wtrRain;

  /// No description provided for @wtrHeavyRain.
  ///
  /// In en, this message translates to:
  /// **'Heavy Rain'**
  String get wtrHeavyRain;

  /// No description provided for @wtrIsolatedShower.
  ///
  /// In en, this message translates to:
  /// **'Isolated Shower'**
  String get wtrIsolatedShower;

  /// No description provided for @wtrSevereThunderStorm.
  ///
  /// In en, this message translates to:
  /// **'Severe Thunder Storm'**
  String get wtrSevereThunderStorm;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get now;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get windSpeed;

  /// No description provided for @windDirection.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction'**
  String get windDirection;

  /// No description provided for @weatherForecast.
  ///
  /// In en, this message translates to:
  /// **'Weather Forecast'**
  String get weatherForecast;

  /// No description provided for @glossariumText.
  ///
  /// In en, this message translates to:
  /// **'Glossary'**
  String get glossariumText;

  /// No description provided for @weatherText.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weatherText;

  /// No description provided for @sateliteText.
  ///
  /// In en, this message translates to:
  /// **'Satelite'**
  String get sateliteText;

  /// No description provided for @earthquakeText.
  ///
  /// In en, this message translates to:
  /// **'Earthquake'**
  String get earthquakeText;

  /// No description provided for @weatherGlosariumTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather Glossary'**
  String get weatherGlosariumTitle;

  /// No description provided for @weatherIconDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather Icon Description'**
  String get weatherIconDescriptionTitle;

  /// No description provided for @weatherClearDescription.
  ///
  /// In en, this message translates to:
  /// **'The sky is not covered by clouds or the part of the sky covered by clouds is only 1 okta¹.'**
  String get weatherClearDescription;

  /// No description provided for @weatherPartlyCloudyDescription.
  ///
  /// In en, this message translates to:
  /// **'Cloud-covered sky between 2-3 okta¹.'**
  String get weatherPartlyCloudyDescription;

  /// No description provided for @weatherMostlyCloudyDescription.
  ///
  /// In en, this message translates to:
  /// **'Cloud-covered sky between 4-6 okta¹.'**
  String get weatherMostlyCloudyDescription;

  /// No description provided for @weatherOvercastDescription.
  ///
  /// In en, this message translates to:
  /// **'Cloud-covered sky between 7-8 okta¹.'**
  String get weatherOvercastDescription;

  /// No description provided for @weatherHazeDescription.
  ///
  /// In en, this message translates to:
  /// **'Reduced visibility due to fine particles such as dust or pollution suspended in the air.'**
  String get weatherHazeDescription;

  /// No description provided for @weatherSmokeDescription.
  ///
  /// In en, this message translates to:
  /// **'Dust particles, smoke or harmful gases that create a thick and hazardous layer of air near the ground.'**
  String get weatherSmokeDescription;

  /// No description provided for @weatherFogDescription.
  ///
  /// In en, this message translates to:
  /// **'Water vapor near the ground condenses and becomes cloud-like.'**
  String get weatherFogDescription;

  /// No description provided for @weatherLightRainDescription.
  ///
  /// In en, this message translates to:
  /// **'Rain with rainfall accumulation between 5-20 mm/day or 0.1-5 mm/hour.'**
  String get weatherLightRainDescription;

  /// No description provided for @weatherRainDescription.
  ///
  /// In en, this message translates to:
  /// **'Rain with rainfall accumulation between 20-50 mm/day or 5-20 mm/hour.'**
  String get weatherRainDescription;

  /// No description provided for @weatherHeavyRainDescription.
  ///
  /// In en, this message translates to:
  /// **'Rain with rainfall accumulation >50 mm/day or >20 mm/hour.'**
  String get weatherHeavyRainDescription;

  /// No description provided for @weatherIsolatedShowerDescription.
  ///
  /// In en, this message translates to:
  /// **'Light to moderate rain that falls sporadically in certain locations, with a small area coverage and often does not last long.'**
  String get weatherIsolatedShowerDescription;

  /// No description provided for @weatherSevereThunderStormDescription.
  ///
  /// In en, this message translates to:
  /// **'Rain accompanied by lightning/thunder and strong winds.'**
  String get weatherSevereThunderStormDescription;

  /// No description provided for @aboutOctas.
  ///
  /// In en, this message translates to:
  /// **'[1] Okta is a unit of measurement used to describe the amount of clouds covering the sky at a given location.'**
  String get aboutOctas;

  /// No description provided for @windIconDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction Icon Description'**
  String get windIconDescriptionTitle;

  /// No description provided for @windDirectionNorthDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction from the North (N)'**
  String get windDirectionNorthDescription;

  /// No description provided for @windDirectionNorthEastDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction from the Northeast (NE)'**
  String get windDirectionNorthEastDescription;

  /// No description provided for @windDirectionEastDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction from the East (E)'**
  String get windDirectionEastDescription;

  /// No description provided for @windDirectionSouthEastDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction from Southeast (SE)'**
  String get windDirectionSouthEastDescription;

  /// No description provided for @windDirectionSouthDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction from South (S)'**
  String get windDirectionSouthDescription;

  /// No description provided for @windDirectionSouthWestDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction from Southwest (SW)'**
  String get windDirectionSouthWestDescription;

  /// No description provided for @windDirectionWestDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction from the West (W)'**
  String get windDirectionWestDescription;

  /// No description provided for @windDirectionNorthWestDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction from Northwest (NW)'**
  String get windDirectionNorthWestDescription;

  /// No description provided for @oneWeekForecast.
  ///
  /// In en, this message translates to:
  /// **'Weekly Forecast'**
  String get oneWeekForecast;

  /// No description provided for @radar.
  ///
  /// In en, this message translates to:
  /// **'Radar'**
  String get radar;

  /// No description provided for @radarTypeName.
  ///
  /// In en, this message translates to:
  /// **'{value, select, cmax{CMAX} nowcast{NOWCAST} qpf{QPF} cmaxssa{CMAX-SSA} cmaxhwind{CMAX-HWIND} cappi05{{metric, select, metric{CAPPI 0.5Km} other{CAPPI 0.31mil}} } cappi1{{metric, select, metric{CAPPI 0.5Km} other{CAPPI 0.32mil}}} sri{SRI} pac1{PAC 1h} pac6{PAC 6h} pac12{PAC 12h} pac24{PAC 24h} other{Unknown}}'**
  String radarTypeName(String metric, String value);

  /// No description provided for @sateliteImage.
  ///
  /// In en, this message translates to:
  /// **'Satelite'**
  String get sateliteImage;

  /// No description provided for @nowcast.
  ///
  /// In en, this message translates to:
  /// **'Nowcast'**
  String get nowcast;

  /// No description provided for @maritime.
  ///
  /// In en, this message translates to:
  /// **'Maritime'**
  String get maritime;

  /// No description provided for @windDirectionValue.
  ///
  /// In en, this message translates to:
  /// **'{value, select, north{N} northEast{NE} east{E} southEast{SE} south{S} southWest{SW} west{W} northWest{NW} other{{value}}}'**
  String windDirectionValue(String value);

  /// No description provided for @windDirectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Wind direction from the {direction, select, north{North} northEast{North East} east{East} southEast{South East} south{South} southWest{South West} west{West} northWest{North West} other{{direction}}}'**
  String windDirectionDescription(String direction);

  /// No description provided for @speedWithUnit.
  ///
  /// In en, this message translates to:
  /// **'{metric, select, true{{nan, select, nan{- kmph} other{{value} kmph}}} other{{nan, select, nan{- mph} other{{value}\nmph}}}}'**
  String speedWithUnit(String metric, String nan, num value);

  /// No description provided for @distanceWithUnit.
  ///
  /// In en, this message translates to:
  /// **'{metric, select, true{{nan, select, nan{- km} other{{value} km}}} other{{nan, select, nan{- mile} other{{value, plural, =0{0 mile} =1{1 mile} other{{value} miles}}}}}}'**
  String distanceWithUnit(String metric, String nan, num value);

  /// No description provided for @eqFelt.
  ///
  /// In en, this message translates to:
  /// **'Earthquake Felt'**
  String get eqFelt;

  /// No description provided for @eqRealtime.
  ///
  /// In en, this message translates to:
  /// **'Earthquake Realtime'**
  String get eqRealtime;

  /// No description provided for @eqMagnitude.
  ///
  /// In en, this message translates to:
  /// **'Magnitude'**
  String get eqMagnitude;

  /// No description provided for @eqDepth.
  ///
  /// In en, this message translates to:
  /// **'Depth'**
  String get eqDepth;

  /// No description provided for @eqFeltArea.
  ///
  /// In en, this message translates to:
  /// **'Felt Area'**
  String get eqFeltArea;

  /// No description provided for @tsunamiEarlyWarning.
  ///
  /// In en, this message translates to:
  /// **'Early Warning {value}'**
  String tsunamiEarlyWarning(String value);

  /// No description provided for @instruction.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get instruction;

  /// No description provided for @coordinate.
  ///
  /// In en, this message translates to:
  /// **'Coordinate'**
  String get coordinate;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @showShakeMap.
  ///
  /// In en, this message translates to:
  /// **'Show ShakeMap'**
  String get showShakeMap;

  /// No description provided for @hideShakeMap.
  ///
  /// In en, this message translates to:
  /// **'Hide ShakeMap'**
  String get hideShakeMap;

  /// No description provided for @eqWarning.
  ///
  /// In en, this message translates to:
  /// **'{type, select, felt{Earthquake Felt} mover5{M>5 Earthquake} pd1{Tsunami EW-1} pd2{Tsunami EW-2} pd3{Tsunami EW-3} pd4{Tsunami EW-4} other{-}}'**
  String eqWarning(String type);

  /// No description provided for @eqMenuType.
  ///
  /// In en, this message translates to:
  /// **'{type, select, map{Map}  felt{Felt} realtime{Newest} overfive{M > 5} tsunami{Tsunami} other{-}}'**
  String eqMenuType(String type);

  /// No description provided for @eqDistance.
  ///
  /// In en, this message translates to:
  /// **'{nan, select, nan{-} other{{distance} {metric, select, true{km} other{{nan, select, nan{- mile} other{{distance, plural, =0{mile} =1{mile} other{miles}}}}}} from your location ({location, select, null{-} other{{location}}})}}'**
  String eqDistance(String nan, String metric, String location, num distance);

  /// No description provided for @legend.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get legend;

  /// No description provided for @rainIntensity.
  ///
  /// In en, this message translates to:
  /// **'Rain Intensity'**
  String get rainIntensity;

  /// No description provided for @rainLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get rainLight;

  /// No description provided for @rainModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get rainModerate;

  /// No description provided for @rainHeavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get rainHeavy;

  /// No description provided for @rainVeryHeavy.
  ///
  /// In en, this message translates to:
  /// **'Very Heavy'**
  String get rainVeryHeavy;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// No description provided for @waveHeightStatus.
  ///
  /// In en, this message translates to:
  /// **'{status, select, calm{Calm} low{Low} medium{Medium} high{High} veryhigh{Very Heigh} extreme{Extreme} veryextreme{Very Extreme} other{Unkown}}'**
  String waveHeightStatus(String status);

  /// No description provided for @illumination.
  ///
  /// In en, this message translates to:
  /// **'{value}% Illuminated'**
  String illumination(double value);

  /// No description provided for @riseSetText.
  ///
  /// In en, this message translates to:
  /// **'Rise - Set'**
  String get riseSetText;

  /// No description provided for @sunText.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunText;

  /// No description provided for @sunriseText.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunriseText;

  /// No description provided for @sunsetText.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunsetText;

  /// No description provided for @moonText.
  ///
  /// In en, this message translates to:
  /// **'Moon'**
  String get moonText;

  /// No description provided for @moonriseText.
  ///
  /// In en, this message translates to:
  /// **'Moonrise'**
  String get moonriseText;

  /// No description provided for @moonsetText.
  ///
  /// In en, this message translates to:
  /// **'Moonset'**
  String get moonsetText;

  /// No description provided for @moonphaseText.
  ///
  /// In en, this message translates to:
  /// **'{status, select, newMoon{New Moon} waxingCrescent{Waxing Crescent} firstQuarter{First Quarter} waxingGibbous{Waxing Gibbous} fullMoon{Full Moon} waningGibbous{Waning Gibbous} lastQuarter{Last Quarter} waningCrescent{Waning Crescent} other{Unkown}}'**
  String moonphaseText(String status);
}

class _StringsDelegate extends LocalizationsDelegate<Strings> {
  const _StringsDelegate();

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(lookupStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_StringsDelegate old) => false;
}

Strings lookupStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return StringsEn();
    case 'id': return StringsId();
  }

  throw FlutterError(
    'Strings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
