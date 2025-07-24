import 'package:flutter/material.dart';
import 'dart:async';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  Timer? _timer;

  ThemeNotifier() {
    _initTimeBasedSwitch();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    _timer?.cancel(); // Cancel any time-based switch
    if (mode == ThemeMode.system) {
      _initTimeBasedSwitch(); // Re-init if using system or time
    }
    notifyListeners();
  }

  void _initTimeBasedSwitch() {
    final now = DateTime.now();
    if (now.hour >= 18 || now.hour < 6) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    notifyListeners();

    // Schedule next update at next 6AM or 6PM
    final nextSwitch = now.hour >= 18
        ? DateTime(now.year, now.month, now.day + 1, 6)
        : DateTime(now.year, now.month, now.day, 18);
    final duration = nextSwitch.difference(now);

    _timer = Timer(duration, _initTimeBasedSwitch);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
