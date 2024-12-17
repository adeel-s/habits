import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFACAFB5),
    surface: Color(0xFF151B2C),
  ),
  primaryColor: Color(0xFF3E465C),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFACAFB5)),
    bodyMedium: TextStyle(color: Color(0xFFACAFB5)),
    bodySmall: TextStyle(color: Color(0xFFACAFB5)),
  ),
  appBarTheme: AppBarTheme(
    foregroundColor: Color(0xFFACAFB5), //this is the color of the appBar text
  ),
  popupMenuTheme: PopupMenuThemeData(
    textStyle: TextStyle(
      color: Color(0xFFACAFB5), //This isn't working
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
  ),
);
//sign out dialog text color
//appbar menu text color
//text color
//0xFFACAFB5
//accent color
//0xFF3E465C

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFFE5EAF7),
    ));
