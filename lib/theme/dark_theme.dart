import 'package:flutter/material.dart';
import 'custom_colors.dart';

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepOrange,
  brightness: Brightness.dark,
);

final darkCustomColors = CustomColors(
  customBackgroundColor: Colors.black,
  customTextColor: Colors.white,
);

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: darkColorScheme,
  extensions: [darkCustomColors],
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkColorScheme.onPrimaryContainer,
      foregroundColor: darkColorScheme.primaryContainer,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: darkColorScheme.secondary,
    ),
  ),
);