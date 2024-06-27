import 'package:flutter/material.dart';

class HistouryTheme {
  // Lichtes Theme
  static final ThemeData light = ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white70,
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 16),
      // ... Weitere TextStyles
    ),
    // ... Weitere Theme-Anpassungen
    // Hintergrund richtig weiß machen
    colorScheme: ColorScheme.fromSwatch().copyWith(background: Colors.white),
    // App Bar Title schwarz machen
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.indigo,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      indicatorColor: Colors.indigo,
      backgroundColor: Colors.white,
    ),
  );
}
