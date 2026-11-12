import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system));

  void toggleTheme() {
    final isCurrentlyDark = state.themeMode == ThemeMode.dark;

    emit(
      ThemeState(themeMode: isCurrentlyDark ? ThemeMode.light : ThemeMode.dark),
    );
  }

  void setTheme(ThemeMode mode) {
    emit(ThemeState(themeMode: mode));
  }
}
