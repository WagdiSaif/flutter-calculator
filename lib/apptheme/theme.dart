import 'package:calculator/provider/calculator_setting.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); //thie private constractor

  static final ThemeData _lightTheme = ThemeData(
     appBarTheme: AppBarTheme(foregroundColor: Colors.grey[400],
     elevation: 0.0,
      backgroundColor: Color(0xFFFFFFFF),surfaceTintColor: Color(0xFFFFFFFF),),
      scaffoldBackgroundColor: Color(0xFFffffff),
      iconButtonTheme: IconButtonThemeData(style: ElevatedButton.styleFrom(
        foregroundColor: Colors.orange,
      )),
      textTheme: const TextTheme(
              labelMedium: TextStyle(color: Color(0xFFFFFFFF),fontSize: 18,fontWeight: FontWeight.bold),
        displayLarge: TextStyle(color: Color(0xFF000000),fontSize: 20,fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 23, fontWeight: FontWeight.normal,color: Color(0xFF000000)),
          displaySmall: TextStyle(fontSize: 23, fontWeight: FontWeight.normal,color: Color(0xFFFF8D0F),
          ),
          bodySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Color(0xFF000000))
          
          ),
      
      colorScheme: ColorScheme(
        
          primary: const Color(0xFFFF8D0F),
          secondary: const Color(0xFF4d4d6e),
          surface: const Color(0xF2F2F2F2),
          
        //  background: const Color(0xFFF8C6C6),
          error: const Color(0xFFff0000),
          onPrimary: const Color(0xFFDBDBF9),
          onSecondary: const Color(0xFF262636),
          onSurface: Colors.grey[600]!,
          //
          onBackground: Colors.blueGrey.shade200,
          onError: const Color(0xFFFFFFFF),
          brightness: Brightness.light,
          primaryContainer: const Color(0xFFDBDBF9),
          secondaryContainer: const Color(0xFF4d4d6e)));

          //dark Theme

          static final ThemeData _darkTheme=ThemeData(
            textTheme: TextTheme(
              labelMedium: TextStyle(color: Color(0xFFFFFFFF),fontSize: 18,fontWeight: FontWeight.bold),
              displayLarge: TextStyle(color: Color(0xFFFFFFFF),fontSize: 20,fontWeight: FontWeight.bold),
              displayMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Color(0xFFFFFFFF)),
              displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Color(0xFFFF8D0F)),
                 bodySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Color(0xFFFFFFFF))
          
            ),
            scaffoldBackgroundColor: Color(0xFF121212),
            
            brightness: Brightness.dark,primaryColor:
             Color(0xFF121212),
          
            appBarTheme: AppBarTheme(
              color: Color(0xFF000000),
            
            ),
            colorScheme: ColorScheme.dark(
              onPrimary: Color(0xFFFF8D0F),

              primary: Color(0xFF000000),
             background :  Color(0xFF000000),
              surface: Color(0xFF1E1E1E),
              brightness: Brightness.dark,
              surfaceVariant: Color(0xFF2D2D2D),
              surfaceBright: Color(0xFF383838)

            ));
            // Use this tool in debug mode
           
}


ThemeData get appTheme=>CalculatorSetting.instance.modeThemeState?AppTheme._lightTheme: AppTheme._darkTheme;