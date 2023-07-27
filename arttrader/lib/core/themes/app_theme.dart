import 'package:flutter/material.dart';

class CustomTheme {
  static const Color primaryColor = Color(0xFF303030);
  static const Color accentColor = Color(0xFFE91E63); // A complementary color

  static const Color darkGrey = Color(0xFF303030);
  static const Color grey = Color(0xFF757575);
  static const Color lightGrey = Color(0xFFBDBDBD);
  static const Color extraLightGrey = Color(0xFFF5F5F5);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkGrey,
    cardColor: grey,
    dividerColor: lightGrey,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: accentColor.withOpacity(0.5),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: white), // For app bar titles
      bodyMedium: TextStyle(color: white), // For general body text
      bodySmall: TextStyle(color: lightGrey), // For captions and small texts
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkGrey,
      toolbarTextStyle: const TextTheme(
        titleLarge: TextStyle(color: white, fontSize: 20.0),
      ).bodyMedium,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(color: white, fontSize: 20.0),
      ).titleLarge,
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: accentColor, background: darkGrey),
  );

  static final ThemeData lightTheme =
      ThemeData.light(useMaterial3: true).copyWith(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: accentColor, background: extraLightGrey),
    scaffoldBackgroundColor: extraLightGrey,
    cardColor: white,
    dividerColor: lightGrey,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: accentColor.withOpacity(0.5),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: black), // For app bar titles
      bodyMedium: TextStyle(color: black), // For general body text
      bodySmall: TextStyle(color: grey), // For captions and small texts
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: extraLightGrey,
      toolbarTextStyle: const TextTheme(
        displayLarge: TextStyle(color: black, fontSize: 20.0),
      ).bodyMedium,
      titleTextStyle: const TextTheme(
        titleLarge: TextStyle(color: black, fontSize: 20.0),
      ).titleLarge,
    ),
    //colorScheme: ColorScheme.fromSwatch().copyWith(background: extraLightGrey),
  );
}
