import 'package:flutter/material.dart';
import 'package:lg_ai_touristic_explorer/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) async {
    _themeData = theme;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedTheme = "";
    if (theme == primary) {
      selectedTheme = 'primary';
    } else if (theme == profile1) {
      selectedTheme = 'profile1';
    }
    prefs.setString('theme', selectedTheme);
  }

  void toggleTheme(ThemeData theme) {
    setTheme(theme);
  }

  static Future<ThemeChanger> create() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');
    ThemeData initialTheme;
    if (theme == 'primary') {
      initialTheme = primary;
    } else if (theme == 'profile1') {
      initialTheme = profile1;
    } else {
      initialTheme = primary;
    }
    return ThemeChanger(initialTheme);
  }
}