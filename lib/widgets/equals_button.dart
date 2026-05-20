import 'package:calculator/apptheme/theme.dart';
import 'package:calculator/provider/calculator_setting.dart';

import 'package:calculator/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EqualsButton extends StatelessWidget {
  const EqualsButton({required this.onPressedEquals, super.key});
  final  VoidCallback   onPressedEquals;

  @override
  Widget build(BuildContext context) {
    
    return
    Selector<CalculatorSetting, bool>(
          selector: (_, CalculatorSetting calSetting) => calSetting.isScientificMode,
          builder: (context, isScientificMode, child) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0, top: 2, bottom: 2),
      child: Container(
        alignment: Alignment.center,
                    width:isScientificMode?20.sw(context): 25.sw(context),
        height: 9.2.sh(context),

        //decoration: BoxDecoration(  color: Colors.amber ),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
              appTheme.scaffoldBackgroundColor,
            ),
          ),

          onPressed: onPressedEquals,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
         
            ),

            alignment: Alignment.center,
            width: 20.sw(context),
            height: 7.2.sh(context),

            child: Text(
              '=',
              style: appTheme.textTheme.labelMedium!.copyWith(
                fontSize: 10.sw(context),
              ),
            ),
          ),
        ),
      ),
    );
  
  });}}
