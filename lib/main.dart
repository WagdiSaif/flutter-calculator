import 'package:calculator/screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'provider/calculator_setting.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'apptheme/theme.dart';
import 'provider/expression_evaluator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Future.wait([CalculatorSetting.init()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpressionEvaluator>(
          create: (_) => ExpressionEvaluator(),
        ),
        ChangeNotifierProvider<CalculatorSetting>(
          create: (_) => CalculatorSetting(),
        ),
      ],
      builder: (context, child) {
        return Selector<CalculatorSetting, bool>(
          selector: (context, cal) => cal.isLightModeThemeState,
          builder: (context, _, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Calculator',
              theme: appTheme,
              themeMode: ThemeMode.system,

              home: Home(),
            );
          },
        );
      },
    );
  }
}
