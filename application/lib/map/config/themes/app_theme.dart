import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black,
      primaryColor: Colors.white,
      splashColor: Colors.transparent,
      fontFamily: 'IBM',
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.black87,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}
