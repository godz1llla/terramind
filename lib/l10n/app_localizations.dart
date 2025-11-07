import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
    Locale('ru'),
    Locale('kk')
  ];

  /// Название приложения
  ///
  /// In ru, this message translates to:
  /// **'TerraMind'**
  String get appTitle;

  /// Название русского языка
  ///
  /// In ru, this message translates to:
  /// **'Русский'**
  String get languageRussian;

  /// Название казахского языка
  ///
  /// In ru, this message translates to:
  /// **'Қазақша'**
  String get languageKazakh;

  /// No description provided for @commonCancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get commonDelete;

  /// No description provided for @commonClose.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get commonClose;

  /// No description provided for @commonLater.
  ///
  /// In ru, this message translates to:
  /// **'Позже'**
  String get commonLater;

  /// No description provided for @commonOk.
  ///
  /// In ru, this message translates to:
  /// **'Понятно'**
  String get commonOk;

  /// No description provided for @commonError.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка'**
  String get commonError;

  /// No description provided for @commonNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Не найдено'**
  String get commonNotFound;

  /// No description provided for @homeWelcomeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать в TerraMind'**
  String get homeWelcomeTitle;

  /// No description provided for @homeWelcomeSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'AI-платформа для умного земледелия'**
  String get homeWelcomeSubtitle;

  /// No description provided for @homeStartMap.
  ///
  /// In ru, this message translates to:
  /// **'Начать работу с картой'**
  String get homeStartMap;

  /// No description provided for @homeFeaturesTitle.
  ///
  /// In ru, this message translates to:
  /// **'Основные возможности'**
  String get homeFeaturesTitle;

  /// No description provided for @homeFeatureMapTitle.
  ///
  /// In ru, this message translates to:
  /// **'Интерактивная карта'**
  String get homeFeatureMapTitle;

  /// No description provided for @homeFeatureMapDescription.
  ///
  /// In ru, this message translates to:
  /// **'Создайте участки на карте'**
  String get homeFeatureMapDescription;

  /// No description provided for @homeFeaturePlannerTitle.
  ///
  /// In ru, this message translates to:
  /// **'Планировщик огорода'**
  String get homeFeaturePlannerTitle;

  /// No description provided for @homeFeaturePlannerDescription.
  ///
  /// In ru, this message translates to:
  /// **'Разместите грядки и расчёты'**
  String get homeFeaturePlannerDescription;

  /// No description provided for @homeFeatureAiTitle.
  ///
  /// In ru, this message translates to:
  /// **'AI-Рекомендации'**
  String get homeFeatureAiTitle;

  /// No description provided for @homeFeatureAiDescription.
  ///
  /// In ru, this message translates to:
  /// **'Умные советы для урожая'**
  String get homeFeatureAiDescription;

  /// No description provided for @homeFeatureWikiTitle.
  ///
  /// In ru, this message translates to:
  /// **'База знаний'**
  String get homeFeatureWikiTitle;

  /// No description provided for @homeFeatureWikiDescription.
  ///
  /// In ru, this message translates to:
  /// **'TerraMind Wiki'**
  String get homeFeatureWikiDescription;

  /// No description provided for @homeFeatureCommunityTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сообщество'**
  String get homeFeatureCommunityTitle;

  /// No description provided for @homeFeatureCommunityDescription.
  ///
  /// In ru, this message translates to:
  /// **'SOS-лента и группы'**
  String get homeFeatureCommunityDescription;

  /// No description provided for @homeFeatureEcoTitle.
  ///
  /// In ru, this message translates to:
  /// **'Мой Эко-Вклад'**
  String get homeFeatureEcoTitle;

  /// No description provided for @homeFeatureEcoDescription.
  ///
  /// In ru, this message translates to:
  /// **'Достижения и статистика'**
  String get homeFeatureEcoDescription;

  /// No description provided for @homeFeatureMarketplaceTitle.
  ///
  /// In ru, this message translates to:
  /// **'Маркетплейс'**
  String get homeFeatureMarketplaceTitle;

  /// No description provided for @homeFeatureMarketplaceDescription.
  ///
  /// In ru, this message translates to:
  /// **'Kaspi.kz интеграция'**
  String get homeFeatureMarketplaceDescription;

  /// No description provided for @mapTitle.
  ///
  /// In ru, this message translates to:
  /// **'Карта участков'**
  String get mapTitle;

  /// No description provided for @mapFinish.
  ///
  /// In ru, this message translates to:
  /// **'Завершить'**
  String get mapFinish;

  /// No description provided for @mapMinPointsError.
  ///
  /// In ru, this message translates to:
  /// **'Необходимо минимум 3 точки для создания участка'**
  String get mapMinPointsError;

  /// No description provided for @mapPlotNameTitle.
  ///
  /// In ru, this message translates to:
  /// **'Название участка'**
  String get mapPlotNameTitle;

  /// No description provided for @mapPlotNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Например: Дача, Огород у дома'**
  String get mapPlotNameHint;

  /// Сообщение об успешном создании участка
  ///
  /// In ru, this message translates to:
  /// **'Участок \"{name}\" создан'**
  String mapPlotCreated(String name);

  /// No description provided for @mapPlotConfigure.
  ///
  /// In ru, this message translates to:
  /// **'Настроить'**
  String get mapPlotConfigure;

  /// No description provided for @mapDrawingHint.
  ///
  /// In ru, this message translates to:
  /// **'Режим рисования: нажмите на карту для добавления точек'**
  String get mapDrawingHint;

  /// Количество точек при рисовании
  ///
  /// In ru, this message translates to:
  /// **'{count} точек'**
  String mapDrawingPoints(int count);

  /// No description provided for @mapAttribution.
  ///
  /// In ru, this message translates to:
  /// **'© OpenStreetMap contributors'**
  String get mapAttribution;

  /// No description provided for @plotNotFound.
  ///
  /// In ru, this message translates to:
  /// **'Участок не найден'**
  String get plotNotFound;

  /// Заголовок настройки участка
  ///
  /// In ru, this message translates to:
  /// **'Настройка: {name}'**
  String plotSettingsTitle(String name);

  /// No description provided for @plotMainParameters.
  ///
  /// In ru, this message translates to:
  /// **'Основные параметры'**
  String get plotMainParameters;

  /// No description provided for @plotCropLabel.
  ///
  /// In ru, this message translates to:
  /// **'Культура *'**
  String get plotCropLabel;

  /// No description provided for @plotCropHint.
  ///
  /// In ru, this message translates to:
  /// **'Выберите культуру'**
  String get plotCropHint;

  /// No description provided for @plotSoilLabel.
  ///
  /// In ru, this message translates to:
  /// **'Тип почвы *'**
  String get plotSoilLabel;

  /// No description provided for @plotSoilHint.
  ///
  /// In ru, this message translates to:
  /// **'Выберите тип почвы'**
  String get plotSoilHint;

  /// No description provided for @plotPlantingDate.
  ///
  /// In ru, this message translates to:
  /// **'Дата посадки'**
  String get plotPlantingDate;

  /// No description provided for @plotDatePlaceholder.
  ///
  /// In ru, this message translates to:
  /// **'Выберите дату'**
  String get plotDatePlaceholder;

  /// No description provided for @plotInfoText.
  ///
  /// In ru, this message translates to:
  /// **'После сохранения параметров AI-советник сможет давать персонализированные рекомендации'**
  String get plotInfoText;

  /// No description provided for @plotSaveButton.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить параметры'**
  String get plotSaveButton;

  /// No description provided for @plotSaved.
  ///
  /// In ru, this message translates to:
  /// **'Параметры участка сохранены'**
  String get plotSaved;

  /// No description provided for @plotSavedDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Параметры сохранены'**
  String get plotSavedDialogTitle;

  /// No description provided for @plotSavedDialogQuestion.
  ///
  /// In ru, this message translates to:
  /// **'Хотите получить AI-рекомендации для вашего участка?'**
  String get plotSavedDialogQuestion;

  /// No description provided for @plotGetRecommendations.
  ///
  /// In ru, this message translates to:
  /// **'Получить рекомендации'**
  String get plotGetRecommendations;

  /// No description provided for @plotValidationError.
  ///
  /// In ru, this message translates to:
  /// **'Пожалуйста, заполните все обязательные поля'**
  String get plotValidationError;

  /// No description provided for @cropTomato.
  ///
  /// In ru, this message translates to:
  /// **'Томаты'**
  String get cropTomato;

  /// No description provided for @cropCucumber.
  ///
  /// In ru, this message translates to:
  /// **'Огурцы'**
  String get cropCucumber;

  /// No description provided for @cropMelon.
  ///
  /// In ru, this message translates to:
  /// **'Дыня'**
  String get cropMelon;

  /// No description provided for @cropWatermelon.
  ///
  /// In ru, this message translates to:
  /// **'Арбуз'**
  String get cropWatermelon;

  /// No description provided for @cropPotato.
  ///
  /// In ru, this message translates to:
  /// **'Картофель'**
  String get cropPotato;

  /// No description provided for @cropCarrot.
  ///
  /// In ru, this message translates to:
  /// **'Морковь'**
  String get cropCarrot;

  /// No description provided for @cropCabbage.
  ///
  /// In ru, this message translates to:
  /// **'Капуста'**
  String get cropCabbage;

  /// No description provided for @cropPepper.
  ///
  /// In ru, this message translates to:
  /// **'Перец'**
  String get cropPepper;

  /// No description provided for @cropEggplant.
  ///
  /// In ru, this message translates to:
  /// **'Баклажаны'**
  String get cropEggplant;

  /// No description provided for @cropOnion.
  ///
  /// In ru, this message translates to:
  /// **'Лук'**
  String get cropOnion;

  /// No description provided for @cropGarlic.
  ///
  /// In ru, this message translates to:
  /// **'Чеснок'**
  String get cropGarlic;

  /// No description provided for @cropBeet.
  ///
  /// In ru, this message translates to:
  /// **'Свёкла'**
  String get cropBeet;

  /// No description provided for @cropCorn.
  ///
  /// In ru, this message translates to:
  /// **'Кукуруза'**
  String get cropCorn;

  /// No description provided for @cropWheat.
  ///
  /// In ru, this message translates to:
  /// **'Пшеница'**
  String get cropWheat;

  /// No description provided for @cropRice.
  ///
  /// In ru, this message translates to:
  /// **'Рис'**
  String get cropRice;

  /// No description provided for @cropApple.
  ///
  /// In ru, this message translates to:
  /// **'Яблоки'**
  String get cropApple;

  /// No description provided for @cropGrape.
  ///
  /// In ru, this message translates to:
  /// **'Виноград'**
  String get cropGrape;

  /// No description provided for @soilChernozem.
  ///
  /// In ru, this message translates to:
  /// **'Чернозём'**
  String get soilChernozem;

  /// No description provided for @soilSandy.
  ///
  /// In ru, this message translates to:
  /// **'Песчаная'**
  String get soilSandy;

  /// No description provided for @soilClay.
  ///
  /// In ru, this message translates to:
  /// **'Глинистая'**
  String get soilClay;

  /// No description provided for @soilLoam.
  ///
  /// In ru, this message translates to:
  /// **'Суглинистая'**
  String get soilLoam;

  /// No description provided for @soilPeat.
  ///
  /// In ru, this message translates to:
  /// **'Торфяная'**
  String get soilPeat;

  /// No description provided for @soilLime.
  ///
  /// In ru, this message translates to:
  /// **'Известковая'**
  String get soilLime;

  /// No description provided for @soilSaline.
  ///
  /// In ru, this message translates to:
  /// **'Солончаковая'**
  String get soilSaline;

  /// No description provided for @aiPersonalAdviceTitle.
  ///
  /// In ru, this message translates to:
  /// **'Персональные советы от AI'**
  String get aiPersonalAdviceTitle;

  /// No description provided for @aiExtraTipsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Дополнительные советы'**
  String get aiExtraTipsTitle;

  /// No description provided for @aiForecastTitle.
  ///
  /// In ru, this message translates to:
  /// **'Прогноз на 3 дня'**
  String get aiForecastTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
