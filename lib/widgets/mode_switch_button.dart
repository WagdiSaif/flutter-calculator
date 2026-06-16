import 'package:calculator/provider/calculator_setting.dart';
import 'package:calculator/core/constants.dart';
import 'package:calculator/core/extention.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModeSwitchButton extends StatelessWidget {
  const ModeSwitchButton({required this.changeCalculatorMode, super.key});

  final VoidCallback changeCalculatorMode;

  @override
  Widget build(BuildContext context) {
    return Selector<CalculatorSetting, bool>(
      selector: (_, CalculatorSetting calSetting) =>
          calSetting.isScientificMode,
      builder: (context, isScientificMode, child) {
        return Padding(
          padding: EdgeInsets.only(left: 0, right: 0, top: 2, bottom: 2),
          child: Container(
            alignment: Alignment.center,
            width: isScientificMode ? 20.sw(context) : 25.sw(context),
            height: isScientificMode ? 8.sh(context) : 9.2.sh(context),

            //decoration: BoxDecoration(  color: Colors.amber ),
            child: IconButton(
              onPressed: changeCalculatorMode,
              icon: Image(
                width: 8.sw(context),
                height: 10.sh(context),
                image: AssetImage(Constants.rotateBtnIcon),
              ),
            ),
          ),
        );
      },
    );
  }
}
