import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const _storageKey = 'language_code';

  Locale _locale = const Locale('ru');
  bool _initialized = false;

  LanguageProvider() {
    _restoreLocale();
  }

  Locale get locale => _locale;

  bool get isInitialized => _initialized;

  Future<void> _restoreLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_storageKey);
    if (code != null && code.isNotEmpty) {
      _locale = Locale(code);
    }
    _initialized = true;
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, locale.languageCode);
  }
}

