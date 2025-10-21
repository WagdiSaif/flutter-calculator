

import 'package:calculator/provider/calculator_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'apptheme/theme.dart';
import 'provider/exprisson_result.dart';
import 'screens/home.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const  MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
 
  
    return MultiProvider(
   providers: [
   //ExpressionResult
   ChangeNotifierProvider<ExpressionResult>(create:(_)=> ExpressionResult(),)
   ,ChangeNotifierProvider<CalculatorSetting>(create:(_)=> CalculatorSetting.instance,)],
      builder: (context, child) {
        ///
        //final setting=CalculatorSetting.instance;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Calculator',
          theme:appTheme,
          themeMode: ThemeMode.system,
          
          
home: Home(),          // routerConfig: Home(),
        );
      }
    );
  }
}
