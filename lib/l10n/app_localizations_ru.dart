// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'TerraMind';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageKazakh => 'Қазақша';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonLater => 'Позже';

  @override
  String get commonOk => 'Понятно';

  @override
  String get commonError => 'Ошибка';

  @override
  String get commonNotFound => 'Не найдено';

  @override
  String get homeWelcomeTitle => 'Добро пожаловать в TerraMind';

  @override
  String get homeWelcomeSubtitle => 'AI-платформа для умного земледелия';

  @override
  String get homeStartMap => 'Начать работу с картой';

  @override
  String get homeFeaturesTitle => 'Основные возможности';

  @override
  String get homeFeatureMapTitle => 'Интерактивная карта';

  @override
  String get homeFeatureMapDescription => 'Создайте участки на карте';

  @override
  String get homeFeaturePlannerTitle => 'Планировщик огорода';

  @override
  String get homeFeaturePlannerDescription => 'Разместите грядки и расчёты';

  @override
  String get homeFeatureAiTitle => 'AI-Рекомендации';

  @override
  String get homeFeatureAiDescription => 'Умные советы для урожая';

  @override
  String get homeFeatureWikiTitle => 'База знаний';

  @override
  String get homeFeatureWikiDescription => 'TerraMind Wiki';

  @override
  String get homeFeatureCommunityTitle => 'Сообщество';

  @override
  String get homeFeatureCommunityDescription => 'SOS-лента и группы';

  @override
  String get homeFeatureEcoTitle => 'Мой Эко-Вклад';

  @override
  String get homeFeatureEcoDescription => 'Достижения и статистика';

  @override
  String get homeFeatureMarketplaceTitle => 'Маркетплейс';

  @override
  String get homeFeatureMarketplaceDescription => 'Kaspi.kz интеграция';

  @override
  String get mapTitle => 'Карта участков';

  @override
  String get mapFinish => 'Завершить';

  @override
  String get mapMinPointsError =>
      'Необходимо минимум 3 точки для создания участка';

  @override
  String get mapPlotNameTitle => 'Название участка';

  @override
  String get mapPlotNameHint => 'Например: Дача, Огород у дома';

  @override
  String mapPlotCreated(String name) {
    return 'Участок \"$name\" создан';
  }

  @override
  String get mapPlotConfigure => 'Настроить';

  @override
  String get mapDrawingHint =>
      'Режим рисования: нажмите на карту для добавления точек';

  @override
  String mapDrawingPoints(int count) {
    return '$count точек';
  }

  @override
  String get mapAttribution => '© OpenStreetMap contributors';

  @override
  String get plotNotFound => 'Участок не найден';

  @override
  String plotSettingsTitle(String name) {
    return 'Настройка: $name';
  }

  @override
  String get plotMainParameters => 'Основные параметры';

  @override
  String get plotCropLabel => 'Культура *';

  @override
  String get plotCropHint => 'Выберите культуру';

  @override
  String get plotSoilLabel => 'Тип почвы *';

  @override
  String get plotSoilHint => 'Выберите тип почвы';

  @override
  String get plotPlantingDate => 'Дата посадки';

  @override
  String get plotDatePlaceholder => 'Выберите дату';

  @override
  String get plotInfoText =>
      'После сохранения параметров AI-советник сможет давать персонализированные рекомендации';

  @override
  String get plotSaveButton => 'Сохранить параметры';

  @override
  String get plotSaved => 'Параметры участка сохранены';

  @override
  String get plotSavedDialogTitle => 'Параметры сохранены';

  @override
  String get plotSavedDialogQuestion =>
      'Хотите получить AI-рекомендации для вашего участка?';

  @override
  String get plotGetRecommendations => 'Получить рекомендации';

  @override
  String get plotValidationError =>
      'Пожалуйста, заполните все обязательные поля';

  @override
  String get cropTomato => 'Томаты';

  @override
  String get cropCucumber => 'Огурцы';

  @override
  String get cropMelon => 'Дыня';

  @override
  String get cropWatermelon => 'Арбуз';

  @override
  String get cropPotato => 'Картофель';

  @override
  String get cropCarrot => 'Морковь';

  @override
  String get cropCabbage => 'Капуста';

  @override
  String get cropPepper => 'Перец';

  @override
  String get cropEggplant => 'Баклажаны';

  @override
  String get cropOnion => 'Лук';

  @override
  String get cropGarlic => 'Чеснок';

  @override
  String get cropBeet => 'Свёкла';

  @override
  String get cropCorn => 'Кукуруза';

  @override
  String get cropWheat => 'Пшеница';

  @override
  String get cropRice => 'Рис';

  @override
  String get cropApple => 'Яблоки';

  @override
  String get cropGrape => 'Виноград';

  @override
  String get soilChernozem => 'Чернозём';

  @override
  String get soilSandy => 'Песчаная';

  @override
  String get soilClay => 'Глинистая';

  @override
  String get soilLoam => 'Суглинистая';

  @override
  String get soilPeat => 'Торфяная';

  @override
  String get soilLime => 'Известковая';

  @override
  String get soilSaline => 'Солончаковая';

  @override
  String get aiPersonalAdviceTitle => 'Персональные советы от AI';

  @override
  String get aiExtraTipsTitle => 'Дополнительные советы';

  @override
  String get aiForecastTitle => 'Прогноз на 3 дня';
}
