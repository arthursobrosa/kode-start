import 'package:flutter/material.dart';

class AppTheme {
  static ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

  static void setTheme(bool isDark) {
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
