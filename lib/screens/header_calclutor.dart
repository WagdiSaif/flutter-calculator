import 'package:calculator/apptheme/theme.dart';
import 'package:calculator/provider/exprisson_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderCalclutor extends StatelessWidget {
  const HeaderCalclutor({
    required this.width,
    required this.height,
    required this.globalKey,
    super.key,
  });
  final double width;
  final double height;
  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context) {
    final expressionResult = context.watch<ExpressionResult>();
    return Column(
      key: globalKey,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(),
          constraints: BoxConstraints(
            minHeight: height,
            maxHeight: double.infinity,
          ),
          padding: EdgeInsets.all(5),

          alignment: Alignment.bottomRight,
          width: width,
          // height: height,
          child: Column(children: [
            ...List.generate(1, (i) => Align(
            alignment: Alignment.bottomRight,
            child: Text('  ${expressionResult.getResultEvaluate}',style: appTheme.textTheme.bodySmall,),
          )),
          ],)
        ),
        // SizedBox(
        //   height: kToolbarHeight / 4,
        // ),
        Container(
          padding: EdgeInsets.all(9),
          //color: Colors.red,
          alignment: Alignment.centerRight,
          width: width,
          height: height * .10,
          child: Text(
            expressionResult.getExperssion,
            style: appTheme.textTheme.displayLarge,
            maxLines: 2,
          ),
        ),

        SizedBox(height: 10),
      ],
    );
  }
}
