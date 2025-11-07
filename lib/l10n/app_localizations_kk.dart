// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'TerraMind';

  @override
  String get languageRussian => 'Орысша';

  @override
  String get languageKazakh => 'Қазақша';

  @override
  String get commonCancel => 'Бас тарту';

  @override
  String get commonSave => 'Сақтау';

  @override
  String get commonDelete => 'Жою';

  @override
  String get commonClose => 'Жабу';

  @override
  String get commonLater => 'Кейін';

  @override
  String get commonOk => 'Жарайды';

  @override
  String get commonError => 'Қате';

  @override
  String get commonNotFound => 'Табылмады';

  @override
  String get homeWelcomeTitle => 'TerraMind-ке қош келдіңіз';

  @override
  String get homeWelcomeSubtitle => 'Ақылды фермерлікке арналған AI-платформа';

  @override
  String get homeStartMap => 'Картадан бастаңыз';

  @override
  String get homeFeaturesTitle => 'Негізгі мүмкіндіктер';

  @override
  String get homeFeatureMapTitle => 'Интерактивті карта';

  @override
  String get homeFeatureMapDescription => 'Картада учаскелерді жасаңыз';

  @override
  String get homeFeaturePlannerTitle => 'Бақша жоспарлағышы';

  @override
  String get homeFeaturePlannerDescription => 'Егісті орналастырып, есептеңіз';

  @override
  String get homeFeatureAiTitle => 'AI-ұсыныстар';

  @override
  String get homeFeatureAiDescription => 'Өнімге арналған ақылды кеңестер';

  @override
  String get homeFeatureWikiTitle => 'Білім базасы';

  @override
  String get homeFeatureWikiDescription => 'TerraMind Wiki';

  @override
  String get homeFeatureCommunityTitle => 'Қауымдастық';

  @override
  String get homeFeatureCommunityDescription => 'SOS-лентасы және топтар';

  @override
  String get homeFeatureEcoTitle => 'Эко-үлесім';

  @override
  String get homeFeatureEcoDescription => 'Жетістіктер мен статистика';

  @override
  String get homeFeatureMarketplaceTitle => 'Маркетплейс';

  @override
  String get homeFeatureMarketplaceDescription => 'Kaspi.kz интеграциясы';

  @override
  String get mapTitle => 'Учаскелер картасы';

  @override
  String get mapFinish => 'Аяқтау';

  @override
  String get mapMinPointsError => 'Учаске құру үшін кемінде 3 нүкте керек';

  @override
  String get mapPlotNameTitle => 'Учаске атауы';

  @override
  String get mapPlotNameHint => 'Мысалы: Дача, Үй жанындағы бақ';

  @override
  String mapPlotCreated(String name) {
    return '«$name» учаскесі жасалды';
  }

  @override
  String get mapPlotConfigure => 'Баптау';

  @override
  String get mapDrawingHint => 'Сызу режимі: нүкте қосу үшін картаға түртіңіз';

  @override
  String mapDrawingPoints(int count) {
    return '$count нүкте';
  }

  @override
  String get mapAttribution => '© OpenStreetMap үлескерлері';

  @override
  String get plotNotFound => 'Учаске табылмады';

  @override
  String plotSettingsTitle(String name) {
    return 'Баптау: $name';
  }

  @override
  String get plotMainParameters => 'Негізгі параметрлер';

  @override
  String get plotCropLabel => 'Дақыл *';

  @override
  String get plotCropHint => 'Дақылды таңдаңыз';

  @override
  String get plotSoilLabel => 'Топырақ түрі *';

  @override
  String get plotSoilHint => 'Топырақ түрін таңдаңыз';

  @override
  String get plotPlantingDate => 'Егу күні';

  @override
  String get plotDatePlaceholder => 'Күнді таңдаңыз';

  @override
  String get plotInfoText =>
      'Параметрлерді сақтағаннан кейін AI-кеңесші жеке ұсыныстар береді';

  @override
  String get plotSaveButton => 'Параметрлерді сақтау';

  @override
  String get plotSaved => 'Учаске параметрлері сақталды';

  @override
  String get plotSavedDialogTitle => 'Параметрлер сақталды';

  @override
  String get plotSavedDialogQuestion =>
      'Учаскеңізге AI-ұсыныс алғыңыз келе ме?';

  @override
  String get plotGetRecommendations => 'Ұсыныс алу';

  @override
  String get plotValidationError => 'Барлық міндетті өрістерді толтырыңыз';

  @override
  String get cropTomato => 'Қызанақ';

  @override
  String get cropCucumber => 'Қияр';

  @override
  String get cropMelon => 'Қауын';

  @override
  String get cropWatermelon => 'Қарбыз';

  @override
  String get cropPotato => 'Картоп';

  @override
  String get cropCarrot => 'Сәбіз';

  @override
  String get cropCabbage => 'Қырыққабат';

  @override
  String get cropPepper => 'Бұрыш';

  @override
  String get cropEggplant => 'Баклажан';

  @override
  String get cropOnion => 'Пияз';

  @override
  String get cropGarlic => 'Сарымсақ';

  @override
  String get cropBeet => 'Қызылша';

  @override
  String get cropCorn => 'Жүгері';

  @override
  String get cropWheat => 'Бидай';

  @override
  String get cropRice => 'Күріш';

  @override
  String get cropApple => 'Алма';

  @override
  String get cropGrape => 'Жүзім';

  @override
  String get soilChernozem => 'Қара топырақ';

  @override
  String get soilSandy => 'Құмды';

  @override
  String get soilClay => 'Сазды';

  @override
  String get soilLoam => 'Құмсазды';

  @override
  String get soilPeat => 'Торфты';

  @override
  String get soilLime => 'Әкті';

  @override
  String get soilSaline => 'Тұзды';

  @override
  String get aiPersonalAdviceTitle => 'AI-дан жеке кеңестер';

  @override
  String get aiExtraTipsTitle => 'Қосымша кеңестер';

  @override
  String get aiForecastTitle => '3 күндік болжам';
}
