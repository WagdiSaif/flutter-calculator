

import 'package:calculator/apptheme/theme.dart';
import 'package:calculator/provider/calculator_setting.dart';
import 'package:calculator/provider/expression_evaluator.dart';
import 'package:calculator/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
    
class OperationButton extends StatelessWidget {

  const OperationButton({


   required this.btntext,
  this.textStyle,
this.onPressedfun,
    super.key, 
  });
  final String btntext;
final  VoidCallback? onPressedfun;

final TextStyle? textStyle;


  @override
  Widget build(BuildContext context) {

    
  
       return Selector<CalculatorSetting, bool>(
          selector: (_, CalculatorSetting calSetting) => calSetting.isScientificMode,
          builder: (context, isScientificMode, child) {
            return Padding(
          padding: EdgeInsets.only(left: 0, right: 0, top: 1, bottom: 1),
          child: Container(
            alignment: Alignment.center,
            width:isScientificMode?20.0.sw(context): 25.0.sw(context),
            height:isScientificMode? 8.0.sh(context): 10.0.sh(context),
            //decoration: BoxDecoration(  color: Colors.amber ),
          
            child: TextButton(
       style: ButtonStyle(overlayColor:WidgetStatePropertyAll(appTheme.scaffoldBackgroundColor)) ,
              onPressed:onPressedfun??(){
                    final isDegreeMode=  context.read<CalculatorSetting>().checkIsDegree;
                context.read<ExpressionEvaluator>().addExpression(btntext,isDegreeMode);},

              child:
              Text(
                btntext,
                style:textStyle??  appTheme.textTheme.displaySmall!.copyWith(fontSize: 7.0.sw(context)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );});}}