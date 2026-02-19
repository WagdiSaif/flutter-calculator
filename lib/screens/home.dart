import 'package:calculator/provider/calculator_setting.dart';
import 'package:calculator/screens/history.dart';
import 'package:calculator/screens/simple_calculator.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
      isLightMode = Provider.of<CalculatorSetting>(context,listen: false).isLightModeThemeState;
    super.initState();
  }
 late bool isLightMode;
  @override
  Widget build(BuildContext context) {
   
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        centerTitle: true,
        title:   IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              },
              child: Icon(     isLightMode ? Icons.dark_mode : Icons.light_mode,
            
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            onPressed: () async {
                              isLightMode = context.read<CalculatorSetting>().isLightModeThemeState;
              await context.read<CalculatorSetting>().updateThemeModeState();

            },

          ),
        leading: PopupMenuButton(
          itemBuilder: (contex) => [
            PopupMenuItem(
              child: Text('History'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => History()),
              ),
            ),
          ],
        ),
      ),

      //
      body: SimpleCalculator(),
    );
  }
}
