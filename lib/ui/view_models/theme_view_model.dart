import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/theme_repository.dart';

part 'theme_view_model.g.dart';

@riverpod
class ThemeViewModel extends _$ThemeViewModel {
  @override
  FutureOr<ThemeMode> build() =>
      ref.watch(themeRepositoryProvider).getThemeMode();

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncData(mode);
    await ref.read(themeRepositoryProvider).saveThemeMode(mode);
  }
}
