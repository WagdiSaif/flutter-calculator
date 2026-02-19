import 'package:calculator/apptheme/theme.dart';

import 'package:calculator/utils/extention.dart';
import 'package:flutter/material.dart';

class SecondModeButton extends StatelessWidget {
  const SecondModeButton({
    super.key,
    required this.degreeRadianMode,
    required this.btntext,
    required this.textStyle,
    required this.isScientificMode,
    required this.isDegree,
  });
  final String btntext;
  final bool isDegree;

  final TextStyle textStyle;

  final VoidCallback degreeRadianMode;
  final bool isScientificMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
      child: Container(
        alignment: Alignment.center,
        width: isScientificMode ? 20.0.sw(context) : 25.0.sw(context),
        height: isScientificMode ? 8.0.sh(context) : 10.2.sh(context),

        child: TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(
              appTheme.scaffoldBackgroundColor,
            ),
          ),
          onPressed: !isDegree ? null : degreeRadianMode,
          child: Text(
            btntext,
            style: textStyle.copyWith(fontSize: 5.0.sw(context)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
