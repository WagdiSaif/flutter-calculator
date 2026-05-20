import 'package:calculator/apptheme/theme.dart';

import 'package:calculator/utils/extention.dart';
import 'package:flutter/material.dart';

class DegreeRadianSwitch extends StatelessWidget {
  const DegreeRadianSwitch({
    super.key,
    required this.degreeRadianMode,
    required this.btntext,
    required this.textStyle,
    required this.isScientificMode,
    required this.isSecondMode,
  });
  final String btntext;

  final bool isSecondMode;
  final TextStyle textStyle;

  final VoidCallback degreeRadianMode;
  final bool isScientificMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0, top: 2, bottom: 2),
      child: Container(
        alignment: Alignment.center,
        width: isScientificMode ? 20.sw(context) : 25.sw(context),
        height: isScientificMode ? 8.sh(context) : 9.2.sh(context),

        //decoration: BoxDecoration(  color: Colors.amber ),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
              appTheme.scaffoldBackgroundColor,
            ),
          ),
          onPressed: isSecondMode ? null : degreeRadianMode,
          child: Text(
            btntext,
            style: textStyle.copyWith(fontSize: 5.sw(context)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
