import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:terramind/config/api_keys.dart';
import 'package:terramind/models/plot_model.dart';

class AIService {
  static GenerativeModel? _model;

  static GenerativeModel get model {
    _model ??= GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: ApiKeys.geminiApiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 500,
      ),
    );
    return _model!;
  }

  /// Генерирует AI-рекомендации для участка
  static Future<String> generateRecommendations({
    required PlotModel plot,
    required String weather,
    required double temperature,
    required int humidity,
  }) async {
    try {
      final prompt = '''
Ты агроном-эксперт из Казахстана, специализируешься на выращивании в аридном климате. Дай рекомендации для участка:

Культура: ${plot.crop ?? 'Не указана'}
Тип почвы: ${plot.soilType ?? 'Не указан'}
Дата посадки: ${plot.plantingDate?.toString().split(' ')[0] ?? 'Не указана'}
Текущая погода: $weather
Температура: $temperature°C
Влажность: $humidity%

Дай 3-5 конкретных рекомендаций:
1. Полив (когда и сколько)
2. Подкормки (чем и когда)
3. Защита от вредителей
4. Прогноз урожая

Отвечай кратко и по делу, на русском языке. Используй актуальную информацию из интернета если нужно.
''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return response.text ?? 'Не удалось получить рекомендации';
    } catch (e) {
      print('Ошибка Gemini: $e');
      return 'Не удалось получить рекомендации. Проверьте API ключ.';
    }
  }

  /// Анализирует фото растения (будущая функция)
  static Future<String> analyzePlantPhoto(String imagePath) async {
    // TODO: Реализовать с vision API Gemini
    return 'Функция распознавания болезней по фото будет доступна в следующей версии';
  }

  /// Генерирует советы по севообороту
  static Future<String> generateRotationAdvice(List<PlotModel> plots) async {
    try {
      final cropsHistory =
          plots.map((p) => p.crop).where((c) => c != null).join(', ');

      final prompt = '''
История посевов: $cropsHistory

Дай рекомендации по севообороту на следующий сезон:
- Что посадить после этих культур
- Какие культуры восстановят почву
- Оптимальная последовательность

Кратко и практично. Используй актуальную информацию из интернета если нужно.
''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return response.text ?? 'Не удалось получить рекомендации';
    } catch (e) {
      print('Ошибка Gemini: $e');
      return 'Ошибка получения рекомендаций';
    }
  }
}
