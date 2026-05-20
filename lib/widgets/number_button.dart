import 'package:calculator/apptheme/theme.dart';
import 'package:calculator/provider/calculator_setting.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/expression_evaluator.dart';
import 'package:calculator/utils/extention.dart';

class NumberButton extends StatelessWidget {
  const NumberButton({
this.isCustomChar=false,
    required this.btntext,

    required this.textStyle,
    super.key, 
  
  });
  final String btntext;
    final bool isCustomChar;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Selector<CalculatorSetting, bool>(
      selector: (_, CalculatorSetting calSetting) =>
          calSetting.isScientificMode,
      builder: (context, isScientificMode, child) {
        return Padding(
          padding: EdgeInsets.only(left: 0, right: 0, top: 1, bottom: 1),
          child: Container(
            alignment: Alignment.center,
            width: isScientificMode ? 20.sw(context) : 25.sw(context),
            height: isScientificMode ? 8.sh(context) : 10.sh(context),

            //decoration: BoxDecoration(  color: Colors.amber ),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(
                  appTheme.scaffoldBackgroundColor,
                ),
              ),
              onPressed: () {
                final isDegreeMode = context
                    .read<CalculatorSetting>()
                    .checkIsDegree;
                context.read<ExpressionEvaluator>().addExpression(
                  btntext,
                  isDegreeMode,
                );
              },
              child: Text(
                btntext,
                style:isCustomChar?textStyle: textStyle.copyWith(fontSize: 8.sw(context)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
