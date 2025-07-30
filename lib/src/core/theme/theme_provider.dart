import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final SharedPreferences? _prefs;

  ThemeProvider([this._prefs]) {
    // Load saved theme preference if prefs is available
    if (_prefs != null) {
      _themeMode = _prefs.getBool('isDark') ?? false 
          ? ThemeMode.dark 
          : ThemeMode.light;
    }
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await _prefs?.setBool('isDark', isDark);
    notifyListeners();
  }
}