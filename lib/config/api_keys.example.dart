// ⚠️ ШАБЛОН конфигурации API ключей
//
// Инструкция:
// 1. Скопируйте этот файл и переименуйте в 'api_keys.dart'
// 2. Замените значения на ваши настоящие API ключи
// 3. api_keys.dart автоматически игнорируется Git для безопасности

class ApiKeys {
  // Google Gemini API ключ
  // Получите на: https://aistudio.google.com/app/apikey
  // Бесплатно: 60 запросов/минуту, 1500 запросов/день
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';

  // OpenWeatherMap API ключ
  // Получите на: https://openweathermap.org/api
  // Бесплатно: 1000 запросов/день
  static const String weatherApiKey = 'YOUR_OPENWEATHERMAP_API_KEY_HERE';
}
