import 'package:calculator/apptheme/theme.dart';
import 'package:calculator/provider/calculator_setting.dart';
import 'package:calculator/provider/expression_evaluator.dart';
import 'package:calculator/utils/extention.dart';
import 'package:calculator/widgets/degree_radian_switch.dart';
import 'package:calculator/widgets/equals_button.dart';
import 'package:calculator/widgets/mode_switch_button.dart';
import 'package:calculator/widgets/number_button.dart';
import 'package:calculator/widgets/operation_button.dart';
import 'package:calculator/widgets/secondmode_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScientificCalculator extends StatelessWidget {
  final GlobalKey keyBoardKey;
  final CalculatorSetting calculatorSetting;
  const ScientificCalculator({
    required this.keyBoardKey,
    super.key,
    required this.calculatorSetting,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: keyBoardKey,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Divider(height: 9),

        Row(
          children: [
            SecondModeButton(
              btntext: '2nd',
              isDegree: calculatorSetting.checkIsDegree,
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                color: !calculatorSetting.checkIsDegree
                    ? Colors.grey[500]
                    : calculatorSetting.isLightModeThemeState? Colors.black:Colors.white,
                fontSize: 5.0.sw(context),
              ),
              degreeRadianMode: () {
                
                calculatorSetting.updatetSecondMode(
                  calculatorSetting.getSecondMode,
                );
              },
              isScientificMode: calculatorSetting.isScientificMode,
            ),

            DegreeRadianSwitch(
              isSecondMode: calculatorSetting.getSecondMode,
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
                color: calculatorSetting.getSecondMode
                    ? Colors.grey[500]
                    :calculatorSetting.isLightModeThemeState? Colors.black:Colors.white,
              ),
              btntext: calculatorSetting.checkIsDegree ? 'deg' : 'rad',
              degreeRadianMode: () {
                calculatorSetting.updateDegreeRadian(
                  calculatorSetting.checkIsDegree,
                );
              },
              isScientificMode: calculatorSetting.isScientificMode,
            ),
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: calculatorSetting.getSecondMode ? 'sin⁻¹' : 'sin',
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
            ),

            OperationButton(
              // color: Colors.grey.shade100,
              btntext: calculatorSetting.getSecondMode ? 'cos⁻¹' : 'cos',
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
            ),
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: calculatorSetting.getSecondMode ? 'tan⁻¹' : 'tan',
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
            ),

            // clor: Colors.grey.shade100,
          ],
        ),

        Row(
          children: [
            OperationButton(
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
              // color: Colors.grey.shade100,
              btntext: 'xʸ',
            ),
            OperationButton(
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
              // color: Colors.grey.shade100,
              btntext: 'lg',
            ),
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: 'ln',
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
            ),
            OperationButton(
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
              // color: Colors.grey.shade100,
              btntext: '(',
            ),
            OperationButton(
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
              // color: Colors.grey.shade100,
              btntext: ')',
            ),

            // clor: Colors.grey.shade100,
          ],
        ),
        Row(
          children: [
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: '√x',
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
            ),
            Selector<ExpressionEvaluator, String>(
              selector: (context, obe) => obe.getExpression,
              builder: (context, value, child) {
                return OperationButton(
                  btntext: value.isEmpty ? 'AC' : 'C',
                  onPressedfun: () =>
                      context.read<ExpressionEvaluator>().clearExpression(),
                );
              },
            ),
            OperationButton(
              onPressedfun: () =>
                  context.read<ExpressionEvaluator>().removeLastCharacter(),
              // color: Colors.grey.shade100,
              btntext: '⌫',
            ),
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: '%',
            ),
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: '÷',
            ),
          ],
        ),
        Row(
          children: [
            OperationButton(
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
              // color: Colors.grey.shade100,
              btntext: 'x!',
            ),
            NumberButton(
              btntext: '7',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            NumberButton(
              btntext: '8',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            NumberButton(
              btntext: '9',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: 'x',
            ),
          ],
        ),
        Row(
          children: [
            OperationButton(
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),

              // color: Colors.grey.shade100,
              btntext: '1/x',
            ),
            NumberButton(
              btntext: '4',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            NumberButton(
              btntext: '5',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            NumberButton(
              textStyle: appTheme.textTheme.displayMedium!,
              btntext: '6',
            ),
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: '−',
            ),
          ],
        ),

        //kk
        Row(
          children: [
            OperationButton(
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 5.0.sw(context),
              ),
              // color: Colors.grey.shade100,
              btntext: 'π',
            ),
            NumberButton(
              btntext: '1',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            NumberButton(
              btntext: '2',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            NumberButton(
              btntext: '3',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            OperationButton(
              // color: Colors.grey.shade100,
              btntext: '+',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ModeSwitchButton(
              changeCalculatorMode: () {
                context.read<CalculatorSetting>().setScientificMode = !(context
                    .read<CalculatorSetting>()
                    .isScientificMode);
              },

              // btntext: '+/-',
            ),
            OperationButton(
              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 7.0.sw(context),
              ),
              // color: Colors.grey.shade100,
              btntext: 'e',
            ),
            NumberButton(
              btntext: '0',
              textStyle: appTheme.textTheme.displayMedium!,
            ),
            NumberButton(
              btntext: '.',
              isCustomChar: true,

              textStyle: appTheme.textTheme.displayMedium!.copyWith(
                fontSize: 10.0.sw(context),
              ),
            ),
            Selector<ExpressionEvaluator, String>(
              selector: (_, expressionEvaluator) =>
                  expressionEvaluator.getExpression,

              builder: (context, expreesionValue, child) {
                return EqualsButton(
                  onPressedEquals: () {
                    context
                        .read<ExpressionEvaluator>()
                        .evlauteEndExpressionResult(expreesionValue);
                  },
                );
              },
            ),
          ],
        ),
      ],

      //the second
    );
  }
}
