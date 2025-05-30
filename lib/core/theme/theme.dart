import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontFamily: 'Poppins'),
    displayMedium: TextStyle(fontFamily: 'Poppins'),
    displaySmall: TextStyle(fontFamily: 'Poppins'),
    headlineLarge: TextStyle(fontFamily: 'Poppins'),
    headlineMedium: TextStyle(fontFamily: 'Poppins'),
    headlineSmall: TextStyle(fontFamily: 'Poppins'),
    titleLarge: TextStyle(fontFamily: 'Poppins'),
    titleMedium: TextStyle(fontFamily: 'Poppins'),
    titleSmall: TextStyle(fontFamily: 'Poppins'),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    ),
    labelLarge: TextStyle(fontFamily: 'Poppins'),
    labelMedium: TextStyle(fontFamily: 'Poppins'),
    labelSmall: TextStyle(fontFamily: 'Poppins'),
  ),
);
