import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_repository.g.dart';

@riverpod
ThemeRepository themeRepository(Ref ref) => ThemeRepository();

class ThemeRepository {
  static const _key = 'theme_mode';

  Future<ThemeMode> getThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    return switch (preferences.getString(_key)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_key, mode.name);
  }
}
