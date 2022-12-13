import 'package:flutter/material.dart';

class MyTheme {
  // ignore: non_constant_identifier_names
  static ThemeData Mytheme() {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 255, 255, 255),
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 70, 69, 58),
          onPrimary: Color.fromARGB(255, 230, 235, 64),
          secondary: Color.fromARGB(255, 227, 220, 27),
          onSecondary: Color.fromARGB(255, 40, 40, 36),
          error: Color.fromARGB(255, 221, 8, 8),
          onError: Color.fromARGB(255, 255, 0, 0),
          background: Color.fromARGB(255, 255, 255, 255),
          onBackground: Color.fromARGB(255, 35, 35, 35),
          surface: Color.fromARGB(255, 255, 210, 32),
          onSurface: Color.fromARGB(255, 164, 206, 12)),
      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 52.0, fontWeight: FontWeight.bold, color: Colors.black87),
        displayMedium: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'Hind'),
        displaySmall: TextStyle(
          fontSize: 24.0,
          fontFamily: 'Hind',
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        headlineMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        headlineSmall: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        titleLarge: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        titleMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        titleSmall: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        bodyLarge: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        bodySmall: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        labelLarge: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        labelSmall: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }
}
