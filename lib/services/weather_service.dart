import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  // Open-Meteo API - БЕСПЛАТНЫЙ, БЕЗ КЛЮЧА!
  // https://open-meteo.com/
  static const String _baseUrl = 'https://api.open-meteo.com/v1';

  /// Получает текущую погоду для Кызылорды
  static Future<WeatherData> getCurrentWeather() async {
    try {
      // Координаты Кызылорды
      const lat = 44.8526;
      const lon = 65.5092;

      final url = Uri.parse(
        '$_baseUrl/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m&timezone=Asia/Qyzylorda',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData.fromOpenMeteo(data);
      } else {
        return _getDefaultWeather();
      }
    } catch (e) {
      print('Ошибка получения погоды: $e');
      return _getDefaultWeather();
    }
  }

  /// Получает прогноз на несколько дней
  static Future<List<WeatherForecast>> getForecast() async {
    try {
      const lat = 44.8526;
      const lon = 65.5092;

      final url = Uri.parse(
        '$_baseUrl/forecast?latitude=$lat&longitude=$lon&daily=temperature_2m_max,temperature_2m_min,precipitation_sum,weathercode&timezone=Asia/Qyzylorda&forecast_days=7',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final daily = data['daily'];

        final List<WeatherForecast> forecasts = [];
        for (int i = 0; i < 5; i++) {
          forecasts.add(WeatherForecast(
            date: DateTime.parse(daily['time'][i]),
            tempMax: daily['temperature_2m_max'][i].toDouble(),
            tempMin: daily['temperature_2m_min'][i].toDouble(),
            precipitation: daily['precipitation_sum'][i].toDouble(),
            weatherCode: daily['weathercode'][i],
          ));
        }

        return forecasts;
      } else {
        return _getDefaultForecast();
      }
    } catch (e) {
      print('Ошибка получения прогноза: $e');
      return _getDefaultForecast();
    }
  }

  /// Фоллбек данные
  static WeatherData _getDefaultWeather() {
    return WeatherData(
      temperature: 15.0,
      humidity: 40,
      windSpeed: 10.0,
      description: 'Ясно',
      city: 'Кызылорда',
    );
  }

  static List<WeatherForecast> _getDefaultForecast() {
    return List.generate(5, (i) {
      return WeatherForecast(
        date: DateTime.now().add(Duration(days: i)),
        tempMax: 20.0 - i * 2,
        tempMin: 10.0 - i,
        precipitation: 0,
        weatherCode: 0,
      );
    });
  }
}

/// Модель данных погоды
class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String description;
  final String city;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.city,
  });

  factory WeatherData.fromOpenMeteo(Map<String, dynamic> json) {
    final current = json['current_weather'];
    final hourly = json['hourly'];

    // Получаем влажность из почасовых данных (последнее значение)
    final humidity = hourly['relativehumidity_2m'].last as int;

    return WeatherData(
      temperature: current['temperature'].toDouble(),
      humidity: humidity,
      windSpeed: current['windspeed'].toDouble(),
      description: _getWeatherDescription(current['weathercode']),
      city: 'Кызылорда',
    );
  }

  static String _getWeatherDescription(int code) {
    // WMO Weather interpretation codes
    switch (code) {
      case 0:
        return 'Ясно';
      case 1:
      case 2:
      case 3:
        return 'Облачно';
      case 45:
      case 48:
        return 'Туман';
      case 51:
      case 53:
      case 55:
        return 'Морось';
      case 61:
      case 63:
      case 65:
        return 'Дождь';
      case 71:
      case 73:
      case 75:
        return 'Снег';
      case 77:
        return 'Снежная крупа';
      case 80:
      case 81:
      case 82:
        return 'Ливень';
      case 85:
      case 86:
        return 'Снегопад';
      case 95:
        return 'Гроза';
      case 96:
      case 99:
        return 'Гроза с градом';
      default:
        return 'Переменная облачность';
    }
  }

  String get weatherIcon {
    if (description.contains('Ясно')) return '☀️';
    if (description.contains('Облачно')) return '☁️';
    if (description.contains('Дождь') || description.contains('Ливень'))
      return '🌧️';
    if (description.contains('Снег')) return '❄️';
    if (description.contains('Гроза')) return '⛈️';
    return '🌤️';
  }
}

/// Модель прогноза
class WeatherForecast {
  final DateTime date;
  final double tempMax;
  final double tempMin;
  final double precipitation;
  final int weatherCode;

  WeatherForecast({
    required this.date,
    required this.tempMax,
    required this.tempMin,
    required this.precipitation,
    required this.weatherCode,
  });

  String get description {
    return WeatherData._getWeatherDescription(weatherCode);
  }

  bool get isCritical {
    return tempMin < 5 || precipitation > 20; // Заморозки или сильный дождь
  }

  String get icon {
    if (weatherCode == 0) return '☀️';
    if (weatherCode >= 1 && weatherCode <= 3) return '☁️';
    if (weatherCode >= 61 && weatherCode <= 65) return '🌧️';
    if (weatherCode >= 71 && weatherCode <= 75) return '❄️';
    if (weatherCode == 95) return '⛈️';
    return '🌤️';
  }
}
