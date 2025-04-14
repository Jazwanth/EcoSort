import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences? _prefs;
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _loadFromPrefs();
  }

  Future<void> toggleTheme() async {
    _darkTheme = !_darkTheme;
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> _initPrefs() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
    } catch (e) {
      debugPrint('Error initializing SharedPreferences: $e');
    }
  }

  Future<void> _loadFromPrefs() async {
    try {
      await _initPrefs();
      _darkTheme = _prefs?.getBool(key) ?? false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme preference: $e');
    }
  }

  Future<void> _saveToPrefs() async {
    try {
      await _initPrefs();
      await _prefs?.setBool(key, _darkTheme);
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
    }
  }
} 