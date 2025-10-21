
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../provider/exprisson_result.dart';

class MainButton extends StatelessWidget {
  final String? btntext;
  final void Function()? onPressed;
  final double height;
  final double width;
  final Widget? btnWidget;
  final TextStyle? textStyle;

  Color? textColor;
  MainButton({super.key, 
    this.textColor = Colors.black,
     this.btntext,
    this.btnWidget,
     this.onPressed,
    required this.height,
    required this.width,
    this.textStyle
  });
  
 int selector(int value)   => value+1;

  @override
  Widget build(BuildContext context) {

    return Builder(
     builder: (context) {
      return GestureDetector(
        onTap:onPressed?? () {
     

context.read<ExpressionResult>().changExpression(btntext!);

        },
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
       
            alignment: Alignment.center,
            width: width *.25,
            height: height * .102,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
               // color: color,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                         color: Theme.of(context).scaffoldBackgroundColor,
                      offset: Offset(3.0, 3.0)),
                  BoxShadow(
                      blurRadius: 2.0,
                         color: Theme.of(context).scaffoldBackgroundColor,
                      offset: Offset(-3.0, -3.0))
                ]),

            child: btnWidget ??
            
            Text(
              btntext!
     
              ,
              style: textStyle!.copyWith(fontSize:width*.07),
              textAlign: TextAlign.center,
            ),
         
          ),
        ),
      );
    });
  }
}
