import 'package:flutter/material.dart';
import 'package:terramind/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:terramind/models/plot_model.dart';
import 'package:terramind/providers/plot_provider.dart';
import 'package:terramind/services/ai_service.dart';
import 'package:terramind/services/weather_service.dart';
import 'package:terramind/theme/app_theme.dart';
import 'package:terramind/utils/locale_text.dart';

class AIRecommendationsScreen extends StatefulWidget {
  const AIRecommendationsScreen({super.key});

  @override
  State<AIRecommendationsScreen> createState() =>
      _AIRecommendationsScreenState();
}

class _AIRecommendationsScreenState extends State<AIRecommendationsScreen> {
  WeatherData? _weather;
  String? _aiRecommendations;
  bool _isLoading = false;
  List<PlotModel> _plots = [];

  static const Map<String, String> _weatherDescriptionKk = {
    'Ясно': 'Ашық',
    'Облачно': 'Бұлтты',
    'Туман': 'Тұман',
    'Морось': 'Сіркіреу',
    'Дождь': 'Жаңбыр',
    'Снег': 'Қар',
    'Снежная крупа': 'Қатты қар түйіршігі',
    'Ливень': 'Қатты жаңбыр',
    'Снегопад': 'Қар жауады',
    'Гроза': 'Найзағай',
    'Гроза с градом': 'Бұршақпен найзағай',
    'Переменная облачность': 'Айнымалы бұлт',
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      // Загружаем погоду
      _weather = await WeatherService.getCurrentWeather();

      // Получаем участки
      final plotProvider = Provider.of<PlotProvider>(context, listen: false);
      _plots = plotProvider.plots;

      // Генерируем AI рекомендации для первого участка с данными
      if (_plots.isNotEmpty) {
        final plotWithData = _plots.firstWhere(
          (p) => p.crop != null && p.soilType != null,
          orElse: () => _plots.first,
        );

        if (plotWithData.crop != null && plotWithData.soilType != null) {
          _aiRecommendations = await AIService.generateRecommendations(
            plot: plotWithData,
            weather: _weather!.description,
            temperature: _weather!.temperature,
            humidity: _weather!.humidity,
          );
        }
      }
    } catch (e) {
      print('Ошибка загрузки данных: $e');
    }

    setState(() => _isLoading = false);
  }

  Future<void> _refresh() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.homeFeatureAiTitle),
        actions: [
          IconButton(
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _refresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Погодный виджет
              _buildWeatherWidget(loc),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AI Рекомендации
                    if (_aiRecommendations != null) ...[
                      Row(
                        children: [
                          Icon(Icons.psychology,
                              color: AppTheme.accentPurple, size: 28),
                          const SizedBox(width: 12),
                          Text(
                            loc.homeFeatureAiTitle,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Card(
                        color: AppTheme.accentPurple.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppTheme.accentPurple,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.auto_awesome,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      loc.aiPersonalAdviceTitle,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _aiRecommendations!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Прогноз погоды
                    _buildForecastSection(loc),

                    const SizedBox(height: 24),

                    // Статичные рекомендации (фоллбек)
                    Text(
                      loc.aiExtraTipsTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildStaticRecommendations(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherWidget(AppLocalizations loc) {
    if (_weather == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.accentBlue,
              AppTheme.accentTeal,
            ],
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    final localizedCity = localizedText(
      context,
      ru: _weather!.city,
      kk: 'Қызылорда',
    );
    final weatherDescription = _localizedWeatherDescription(_weather!.description);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.accentBlue,
            AppTheme.accentTeal,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizedCity,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    weatherDescription,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    _weather!.weatherIcon,
                    style: const TextStyle(fontSize: 32),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${_weather!.temperature.toStringAsFixed(0)}°C',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                localizedText(
                  context,
                  ru: 'Влажность: ${_weather!.humidity}%',
                  kk: 'Ылғалдылық: ${_weather!.humidity}%',
                ),
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                localizedText(
                  context,
                  ru: 'Ветер: ${_weather!.windSpeed.toStringAsFixed(0)} км/ч',
                  kk:
                      'Жел: ${_weather!.windSpeed.toStringAsFixed(0)} км/сағ',
                ),
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForecastSection(AppLocalizations loc) {
    return FutureBuilder<List<WeatherForecast>>(
      future: WeatherService.getForecast(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final forecast = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loc.aiForecastTitle,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forecast.length,
                itemBuilder: (context, index) {
                  final item = forecast[index];
                  final isCritical = item.isCritical;

                  return Card(
                    color: isCritical ? Colors.red.shade50 : null,
                    margin: const EdgeInsets.only(right: 12),
                    child: Container(
                      width: 110,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${item.date.day}.${item.date.month}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.icon,
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.tempMax.toStringAsFixed(0)}° / ${item.tempMin.toStringAsFixed(0)}°',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isCritical ? Colors.red : null,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _localizedWeatherDescription(item.description),
                            style: const TextStyle(fontSize: 11),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          if (isCritical) ...[
                            const SizedBox(height: 4),
                            const Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStaticRecommendations(BuildContext context) {
    return Column(
      children: [
        _buildRecommendationCard(
          context,
          'Подкормка азотом',
          'Рекомендуем подкормку',
          'Используйте мочевину (карбамид) 20-30г на 10л воды.',
          Icons.science,
          AppTheme.accentOrange,
          hasAction: true,
        ),
        _buildRecommendationCard(
          context,
          'Полезные статьи',
          'Из базы знаний',
          'Как правильно поливать томаты в жаркую погоду',
          Icons.menu_book,
          AppTheme.accentBlue,
          hasAction: false,
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
      BuildContext context,
      String title,
      String subtitle,
      String description,
      IconData icon,
      Color color,
      {bool hasAction = false}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizedText(
                          context,
                          ru: title,
                          kk: _translateStaticTitle(title),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        localizedText(
                          context,
                          ru: subtitle,
                          kk: _translateStaticSubtitle(subtitle),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              localizedText(
                context,
                ru: description,
                kk: _translateStaticDescription(description),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            if (hasAction) ...[
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => context.push('/marketplace'),
                icon: const Icon(Icons.shopping_cart),
                label: Text(
                  localizedText(
                    context,
                    ru: 'Купить удобрение',
                    kk: 'Тыңайтқыш сатып алу',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentOrange,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _localizedWeatherDescription(String ru) {
    return localizedText(
      context,
      ru: ru,
      kk: _weatherDescriptionKk[ru] ?? ru,
    );
  }

  String _translateStaticTitle(String ru) {
    switch (ru) {
      case 'Подкормка азотом':
        return 'Азоттық қорек';
      case 'Полезные статьи':
        return 'Пайдалы мақалалар';
      default:
        return ru;
    }
  }

  String _translateStaticSubtitle(String ru) {
    switch (ru) {
      case 'Рекомендуем подкормку':
        return 'Қоректендіру ұсынылады';
      case 'Из базы знаний':
        return 'Білім базасынан';
      default:
        return ru;
    }
  }

  String _translateStaticDescription(String ru) {
    switch (ru) {
      case 'Используйте мочевину (карбамид) 20-30г на 10л воды.':
        return '10 л суға 20-30 г карбамид (мочевина) қолданыңыз.';
      case 'Как правильно поливать томаты в жаркую погоду':
        return 'Ыстықта қызанақты дұрыс суару тәсілдері';
      default:
        return ru;
    }
  }
}
