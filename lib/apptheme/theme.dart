import 'package:calculator/provider/calculator_setting.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Light Theme Colors
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xF2F2F2F2);
  static const Color _lightDivider = Color(0xFFE2E5EA);

  // Dark Theme Colors
  static const Color _darkPrimary = Color(0xFF121212);
  static const Color _darkBackground = Color(0xFF000000);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkSurfaceVariant = Color(0xFF2D2D2D);
  static const Color _darkSurfaceBright = Color(0xFF383838);

  static const Color _accentOrange = Color(0xFFFF8D0F);
  static const Color _accentPurple = Color(0xFF4d4d6e);
  static const Color _accentLightPurple = Color(0xFFDBDBF9);
  static const Color _error = Color(0xFFff0000);

  static const Color _textWhite = Color(0xFFFFFFFF);
  static const Color _textBlack = Color(0xFF000000);
  static const Color _textGrey = Colors.grey;

  static const TextTheme _baseTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),

    displayMedium: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),

    displaySmall: TextStyle(fontSize: 23, fontWeight: FontWeight.normal),
   
    labelMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
   
    bodySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
  );

  // ============== LIGHT THEME ==============
  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,

    primaryColor: _accentOrange,
    scaffoldBackgroundColor: _lightBackground,

    appBarTheme: _lightAppBarTheme,

    iconTheme: const IconThemeData(color: _accentOrange),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: _accentOrange),
    ),

    // Dividers
    dividerTheme: const DividerThemeData(thickness: 2, color: _lightDivider),

    // Text
    textTheme: _baseTextTheme.copyWith(
      displayLarge: const TextStyle(
        color: _textBlack,
      ).merge(_baseTextTheme.displayLarge),
      displayMedium: const TextStyle(
        color: _textBlack,
      ).merge(_baseTextTheme.displayMedium),
      displaySmall: const TextStyle(
        color: _accentOrange,
      ).merge(_baseTextTheme.displaySmall),
      labelMedium: const TextStyle(
        color: _textWhite,
      ).merge(_baseTextTheme.labelMedium),
      bodySmall: const TextStyle(
        color: _textGrey,
      ).merge(_baseTextTheme.bodySmall),
    ),

    colorScheme: const ColorScheme.light(
      primary: _accentOrange,
      secondary: _accentPurple,
      surface: _lightSurface,
      error: _error,
      onPrimary: _accentLightPurple,
      onSecondary: _textWhite,
      onSurface: _textGrey,
      onError: _textWhite,
      primaryContainer: _accentLightPurple,
      secondaryContainer: _accentPurple,
    ),
  );

  // ============== DARK THEME ==============
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,

    primaryColor: _darkPrimary,
    scaffoldBackgroundColor: _darkBackground,

    appBarTheme: _darkAppBarTheme,

    // Icons
    iconTheme: const IconThemeData(color: _accentOrange),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: _accentOrange),
    ),

    // Dividers
    dividerTheme: const DividerThemeData(thickness: 2, color: Colors.grey),

    // Text
    textTheme: _baseTextTheme.copyWith(
      displayLarge: const TextStyle(
        color: _textWhite,
        fontWeight: FontWeight.bold,
      ).merge(_baseTextTheme.displayLarge),
      displayMedium: const TextStyle(
        color: _textWhite,
      ).merge(_baseTextTheme.displayMedium),
      displaySmall: const TextStyle(
        color: _accentOrange,
      ).merge(_baseTextTheme.displaySmall),
      labelMedium: const TextStyle(
        color: _textWhite,
      ).merge(_baseTextTheme.labelMedium),
      bodySmall: const TextStyle(
        color: _textGrey,
      ).merge(_baseTextTheme.bodySmall),
    ),

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: _accentOrange,
      background: _darkBackground,
      surface: _darkSurface,
      onPrimary: _accentOrange,
      surfaceVariant: _darkSurfaceVariant,
      surfaceBright: _darkSurfaceBright,
    ),
  );

  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    elevation: 0.0,
    backgroundColor: _lightBackground,
    foregroundColor: Colors.grey,
    surfaceTintColor: _lightBackground,
    centerTitle: true,
    titleTextStyle: TextStyle(color: _textBlack, fontSize: 15),
    iconTheme: IconThemeData(color: _accentOrange, size: 24),
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0.0,
    backgroundColor: _darkBackground,
    foregroundColor: _textWhite,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(color: _textWhite, fontSize: 15),
    iconTheme: IconThemeData(color: _accentOrange, size: 24),
  );
}

ThemeData get appTheme => CalculatorSetting.instance.isLightModeThemeState
    ? AppTheme._lightTheme
    : AppTheme._darkTheme;
