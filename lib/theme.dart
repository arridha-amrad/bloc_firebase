import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
    primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromARGB(137, 101, 101, 101),
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.white, size: 26),
      unselectedIconTheme: IconThemeData(
        color: Color.fromARGB(137, 101, 101, 101),
        size: 26,
      ),
    ),
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.indigo,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      foregroundColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.black, size: 26),
      unselectedIconTheme: IconThemeData(
        color: Color.fromARGB(137, 101, 101, 101),
        size: 26,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    primaryColor: Colors.white,
  );
}
