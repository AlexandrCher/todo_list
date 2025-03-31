import 'package:flutter/material.dart';
import 'custom_colors.dart';

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepOrange,
);

final lightCustomColors = CustomColors(
  customBackgroundColor: Colors.white,
  customTextColor: Colors.black,
);

final lightTheme = ThemeData.light().copyWith(
  colorScheme: lightColorScheme,
  extensions: [lightCustomColors],
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.onPrimaryContainer,
      foregroundColor: lightColorScheme.primaryContainer,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: lightColorScheme.secondary,
    ),
  ),
);