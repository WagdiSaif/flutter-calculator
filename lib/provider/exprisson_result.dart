import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';


class ExpressionResult extends ChangeNotifier {

  final ContextModel _contextModel=ContextModel();

  int count = 9;
late final Expression exp;
final GrammarParser _parser=GrammarParser();
 

  // ExpressionResult(this.expression, this.result);
  String _expression = '0';
  String result = '';
  String str = 're';
   set setExpression(String expr){_expression=expr;
   notifyListeners();}
   
  String get getExperssion => _expression;
 

 
void evaluateExpression(){
  
 String expr=_expression.replaceAll(r'x', '*');
   expr=expr.replaceAll(r'÷', '/');

final inputString=_parser.parse(expr);

  EvaluationType type=EvaluationType.REAL;
  // final _regExp=RegExp(_expression);
  // exp.evaluate("toVar")

// final vrable=_contextModel.getExpression('33+4');
 final evaluateExpr= inputString.evaluate(type, _contextModel);
 
// p.evaluate(type, context).

// final eval=vrable.evaluate(type, _contextModel).toString();
result=evaluateExpr.toString();
notifyListeners();
}
 void changExpression(String text) {

  
 
    _expression += text;
    _expression=  _expression.replaceFirst(RegExp(r'^0'), '',0);
    //Expacted dot
    
    // modeThemeState=modeThemeState
    notifyListeners();
  }
 String get getResultEvaluate=>result;
void clearExpression(){
  _expression='0';
  notifyListeners();
}

}
