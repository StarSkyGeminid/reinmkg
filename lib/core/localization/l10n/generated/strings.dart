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
  Strings(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
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
  /// **'{unit, select, true{Metric} false{Imperial} other{Unknown}}'**
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

  /// No description provided for @waveCategoryCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get waveCategoryCalm;

  /// No description provided for @waveCategoryLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get waveCategoryLow;

  /// No description provided for @waveCategoryMedium.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get waveCategoryMedium;

  /// No description provided for @waveCategoryHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get waveCategoryHigh;

  /// No description provided for @waveCategoryVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get waveCategoryVeryHigh;

  /// No description provided for @waveCategoryExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get waveCategoryExtreme;

  /// No description provided for @waveCategoryVeryExtreme.
  ///
  /// In en, this message translates to:
  /// **'Very Extreme'**
  String get waveCategoryVeryExtreme;

  /// No description provided for @waveCategory.
  ///
  /// In en, this message translates to:
  /// **'{type, select, calm{Calm} low{Low} medium{Moderate} high{High} veryHigh{Very High} extreme{Extreme} veryExtreme{Very Extreme} other{-}}'**
  String waveCategory(String type);

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

  /// No description provided for @wtrType.
  ///
  /// In en, this message translates to:
  /// **'{type, select, clearSkies{Clear Sky} partlyCloudy{Partly Cloudy} mostlyCloudy{Mostly Cloudy} overcast{Overcast} haze{Haze} smoke{Smoke} fog{Fog} lightRain{Light Rain} rain{Rain} heavyRain{Heavy Rain} isolatedShower{Isolated Shower} severeThunderStorm{Severe Thunder Storm} other{Unknown}}'**
  String wtrType(String type);

  /// No description provided for @wdirType.
  ///
  /// In en, this message translates to:
  /// **'{type, select, north{North} northEast{North East} east{East} southEast{South East} south{South} southWest{South West} west{West} northWest{North West} other{-}}'**
  String wdirType(String type);

  /// No description provided for @dashboardNowLabel.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get dashboardNowLabel;

  /// No description provided for @forecastWeatherLabel.
  ///
  /// In en, this message translates to:
  /// **'Weather Forecast'**
  String get forecastWeatherLabel;

  /// No description provided for @dailyForecastLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily Forecast'**
  String get dailyForecastLabel;

  /// No description provided for @radarLabel.
  ///
  /// In en, this message translates to:
  /// **'Radar'**
  String get radarLabel;

  /// No description provided for @satelliteLabel.
  ///
  /// In en, this message translates to:
  /// **'Satellite'**
  String get satelliteLabel;

  /// No description provided for @nowcastLabel.
  ///
  /// In en, this message translates to:
  /// **'Nowcast'**
  String get nowcastLabel;

  /// No description provided for @maritimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Maritime'**
  String get maritimeLabel;

  /// No description provided for @earthquakeFeltTitle.
  ///
  /// In en, this message translates to:
  /// **'Felt'**
  String get earthquakeFeltTitle;

  /// No description provided for @earthquakeFelt.
  ///
  /// In en, this message translates to:
  /// **'Earthquake felt'**
  String get earthquakeFelt;

  /// No description provided for @earthquakeRealtime.
  ///
  /// In en, this message translates to:
  /// **'Realtime Earthquake'**
  String get earthquakeRealtime;

  /// No description provided for @realtimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Realtime'**
  String get realtimeTitle;

  /// No description provided for @earthquakeMagnitude.
  ///
  /// In en, this message translates to:
  /// **'Magnitude'**
  String get earthquakeMagnitude;

  /// No description provided for @earthquakeDepth.
  ///
  /// In en, this message translates to:
  /// **'Depth'**
  String get earthquakeDepth;

  /// No description provided for @earthquakeTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get earthquakeTime;

  /// No description provided for @unitKm.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get unitKm;

  /// No description provided for @unitMiles.
  ///
  /// In en, this message translates to:
  /// **'miles'**
  String get unitMiles;

  /// No description provided for @magnitudeUnit.
  ///
  /// In en, this message translates to:
  /// **'SR'**
  String get magnitudeUnit;

  /// No description provided for @seismicStation.
  ///
  /// In en, this message translates to:
  /// **'Station: {station}'**
  String seismicStation(String station);

  /// No description provided for @seismicEpicenter.
  ///
  /// In en, this message translates to:
  /// **'Earthquake Epicenter\n{value}'**
  String seismicEpicenter(String value);

  /// No description provided for @seismicPga.
  ///
  /// In en, this message translates to:
  /// **'PGA: {value}'**
  String seismicPga(String value);

  /// No description provided for @seismicPgv.
  ///
  /// In en, this message translates to:
  /// **'PGV: {value}'**
  String seismicPgv(String value);

  /// No description provided for @seismicMmi.
  ///
  /// In en, this message translates to:
  /// **'MMI: {value}'**
  String seismicMmi(String value);

  /// No description provided for @earthquakeFeltInRegency.
  ///
  /// In en, this message translates to:
  /// **'Earthquake felt in {regency}'**
  String earthquakeFeltInRegency(String regency);

  /// No description provided for @weatherAlertIssuedForRegency.
  ///
  /// In en, this message translates to:
  /// **'Early weather alert for {regency} has been issued'**
  String weatherAlertIssuedForRegency(String regency);

  /// No description provided for @fromSubdistrict.
  ///
  /// In en, this message translates to:
  /// **'from {subdistrict}'**
  String fromSubdistrict(String subdistrict);

  /// No description provided for @maritimeLoadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load maritime weather data'**
  String get maritimeLoadError;

  /// No description provided for @maritimeDayLabelToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get maritimeDayLabelToday;

  /// No description provided for @maritimeDayLabelHPlus.
  ///
  /// In en, this message translates to:
  /// **'H+{n}'**
  String maritimeDayLabelHPlus(int n);

  /// No description provided for @noDetailsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No details available'**
  String get noDetailsAvailable;

  /// No description provided for @validFromTo.
  ///
  /// In en, this message translates to:
  /// **'Valid from {from}\nuntil {to}'**
  String validFromTo(String from, String to);

  /// No description provided for @humidityLabel.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidityLabel;

  /// No description provided for @windDirectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Wind Direction'**
  String get windDirectionLabel;

  /// No description provided for @windLabel.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get windLabel;

  /// No description provided for @earthquakeFeltAreaLabel.
  ///
  /// In en, this message translates to:
  /// **'Felt Area'**
  String get earthquakeFeltAreaLabel;

  /// No description provided for @coordinateLabel.
  ///
  /// In en, this message translates to:
  /// **'Coordinate'**
  String get coordinateLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @instructionLabel.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get instructionLabel;

  /// No description provided for @distanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distanceLabel;

  /// No description provided for @legendLabel.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get legendLabel;

  /// No description provided for @eventIdNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Event id not available'**
  String get eventIdNotAvailable;

  /// No description provided for @tsunamiLabel.
  ///
  /// In en, this message translates to:
  /// **'Tsunami'**
  String get tsunamiLabel;

  /// No description provided for @tsunamiWarningZonesLabel.
  ///
  /// In en, this message translates to:
  /// **'Warning Zones'**
  String get tsunamiWarningZonesLabel;

  /// No description provided for @tsunamiWarningInfoAvailable.
  ///
  /// In en, this message translates to:
  /// **'Warning information available'**
  String get tsunamiWarningInfoAvailable;

  /// No description provided for @tsunamiNoWarningData.
  ///
  /// In en, this message translates to:
  /// **'No tsunami warning data'**
  String get tsunamiNoWarningData;

  /// No description provided for @eqType.
  ///
  /// In en, this message translates to:
  /// **'{type, select, felt{Felt} realtime{Realtime} overFive{M > 5} tsunami{Tsunami} other{Unknown}}'**
  String eqType(String type);

  /// No description provided for @showLessLabel.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLessLabel;

  /// No description provided for @showMoreCount.
  ///
  /// In en, this message translates to:
  /// **'Show {count} more'**
  String showMoreCount(int count);

  /// No description provided for @mapLabelWZ.
  ///
  /// In en, this message translates to:
  /// **'WZ Map'**
  String get mapLabelWZ;

  /// No description provided for @mapLabelTT.
  ///
  /// In en, this message translates to:
  /// **'TT Map'**
  String get mapLabelTT;

  /// No description provided for @mapLabelSSM.
  ///
  /// In en, this message translates to:
  /// **'SSM Map'**
  String get mapLabelSSM;

  /// No description provided for @warningPrefix.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warningPrefix;

  /// No description provided for @licensesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licensesSectionTitle;

  /// No description provided for @appLicenseTitle.
  ///
  /// In en, this message translates to:
  /// **'App License'**
  String get appLicenseTitle;

  /// No description provided for @opensourceLicenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Open-source Licenses'**
  String get opensourceLicenseTitle;

  /// No description provided for @mapTileAttribution.
  ///
  /// In en, this message translates to:
  /// **'Esri, HERE, Garmin, (c) OpenStreetMap contributors, and the GIS user community'**
  String get mapTileAttribution;

  /// No description provided for @celestialDataLabel.
  ///
  /// In en, this message translates to:
  /// **'Celestial Data'**
  String get celestialDataLabel;

  /// No description provided for @sunLabel.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunLabel;

  /// No description provided for @sunriseLabel.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunriseLabel;

  /// No description provided for @sunsetLabel.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get sunsetLabel;

  /// No description provided for @moonLabel.
  ///
  /// In en, this message translates to:
  /// **'Moon'**
  String get moonLabel;

  /// No description provided for @moonriseLabel.
  ///
  /// In en, this message translates to:
  /// **'Moonrise'**
  String get moonriseLabel;

  /// No description provided for @moonsetLabel.
  ///
  /// In en, this message translates to:
  /// **'Moonset'**
  String get moonsetLabel;

  /// No description provided for @notAvailableLabel.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailableLabel;

  /// No description provided for @moonPhaseNew.
  ///
  /// In en, this message translates to:
  /// **'New Moon'**
  String get moonPhaseNew;

  /// No description provided for @moonPhaseWaxingCrescent.
  ///
  /// In en, this message translates to:
  /// **'Waxing Crescent'**
  String get moonPhaseWaxingCrescent;

  /// No description provided for @moonPhaseFirstQuarter.
  ///
  /// In en, this message translates to:
  /// **'First Quarter'**
  String get moonPhaseFirstQuarter;

  /// No description provided for @moonPhaseWaxingGibbous.
  ///
  /// In en, this message translates to:
  /// **'Waxing Gibbous'**
  String get moonPhaseWaxingGibbous;

  /// No description provided for @moonPhaseFullMoon.
  ///
  /// In en, this message translates to:
  /// **'Full Moon'**
  String get moonPhaseFullMoon;

  /// No description provided for @moonPhaseWaningGibbous.
  ///
  /// In en, this message translates to:
  /// **'Waning Gibbous'**
  String get moonPhaseWaningGibbous;

  /// No description provided for @moonPhaseLastQuarter.
  ///
  /// In en, this message translates to:
  /// **'Last Quarter'**
  String get moonPhaseLastQuarter;

  /// No description provided for @moonPhaseWaningCrescent.
  ///
  /// In en, this message translates to:
  /// **'Waning Crescent'**
  String get moonPhaseWaningCrescent;

  /// No description provided for @moonPhaseIlluminatedPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Illuminated'**
  String moonPhaseIlluminatedPercent(int percent);

  /// No description provided for @unitMeter.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get unitMeter;

  /// No description provided for @unitFeet.
  ///
  /// In en, this message translates to:
  /// **'ft'**
  String get unitFeet;

  /// No description provided for @dash.
  ///
  /// In en, this message translates to:
  /// **'-'**
  String get dash;

  /// No description provided for @emdash.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get emdash;

  /// No description provided for @validFrom.
  ///
  /// In en, this message translates to:
  /// **'Valid From'**
  String get validFrom;

  /// No description provided for @validUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid Until'**
  String get validUntil;

  /// No description provided for @affectedDistricts.
  ///
  /// In en, this message translates to:
  /// **'Affected Area'**
  String get affectedDistricts;

  /// No description provided for @spreadDistricts.
  ///
  /// In en, this message translates to:
  /// **'Spread Area'**
  String get spreadDistricts;

  /// No description provided for @event.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get event;

  /// No description provided for @severity.
  ///
  /// In en, this message translates to:
  /// **'Severity'**
  String get severity;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;
}

class _StringsDelegate extends LocalizationsDelegate<Strings> {
  const _StringsDelegate();

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(lookupStrings(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_StringsDelegate old) => false;
}

Strings lookupStrings(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return StringsEn();
    case 'id':
      return StringsId();
  }

  throw FlutterError(
    'Strings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
