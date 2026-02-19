import 'package:calculator/model/history_item.dart';
import 'package:calculator/provider/hsitory_provider.dart';
import 'package:calculator/utils/extention.dart';

import 'package:calculator/utils/helper_funactions.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

class ExpressionEvaluator extends ChangeNotifier {
  final _contextModel = ContextModel();

  final GrammarParser _parser = GrammarParser();
  Variable pi = Variable("π");
  Variable euler = Variable("e");
  ExpressionEvaluator() {
    _contextModel.bindVariable(pi, Number(math.pi));
    _contextModel.bindVariable(euler, Number(math.e));

    // Add some custom functions to parser
    _parser.addFunction(
      'lg',
      (List<double> args) => math.log(args[0]) / math.log(10),
    );

    _parser.addFunction('DEG', (args) => (args[0] * (math.pi / 180.0)));
  }

  String _expression = "";
  final RegExp piEuler = RegExp(r"(π|e)$");
  final RegExp loglnReg = RegExp(r'(lg|ln)$');
  final RegExp endsWithRootOrFactorial = RegExp(r'[\^!√]$');
  final RegExp angleRegx = RegExp(r'(sin|cos|tan)$');
  final RegExp inverseAngleRegx = RegExp(r'(arcsin|arccos|arctan)');
  final RegExp operatorRegx = RegExp(r'[-|\+|\*|/|\^]$');
  final RegExp simpleOperatorRegx = RegExp(r'[-|\+|\*|/]$');
  final RegExp hasOperatorBeforeCloseParen = RegExp(r'^(.*[-+*/^]\))');
  final RegExp numericReg = RegExp(r'\d$');

  String resultsEvaluator = '';

  void addExpression(String inputToken, bool isDegreeMode) {
    _expression = _expression.trim();
    resultsEvaluator = '';
    inputToken = _normalizeCurrentInputExpression(inputToken);

    if (_expression.isEmpty && inputToken == "0") {
      return;
    } else if (_expression.isEmpty) {
      _expression = inputToken.contains('^')
          ? '0$inputToken'
          : inputToken == '!'
          ? '0$inputToken'
          : inputToken == '.'
          ? '0$inputToken'
          : inputToken;

      return;
    } else if (numericReg.hasMatch(inputToken)) {
      if (isDegreeMode) {
        _expression = validTringDeg(_expression, inputToken);
        notifyListeners();
        return;
      }
      _expression += inputToken;
    } else if (inputToken.compareTo('.') == 0) {
      if (!numericReg.hasMatch(_expression) &&
          !_expression.endsWith('.') &&
          !_expression.endsWith('°')) {
        _expression += inputToken;
      } else {
        String checkToSetDotOn = '';

        for (var element in _expression.split('').reversed.toList()) {
          if (numericReg.hasMatch(element) ||
              element == '.' ||
              element == '°') {
            checkToSetDotOn = "$element$checkToSetDotOn";
            continue;
          } else {
            break;
          }
        }
        if (!checkToSetDotOn.contains('.')) {
          if (_expression.endsWith('°')) {
            _expression = _expression.replaceFirst(
              RegExp(r'°$'),
              '$inputToken°',
            );
          } else {
            _expression += inputToken;
          }
        }
      }
    } else if (simpleOperatorRegx.hasMatch(inputToken)) {
      if (_expression.endsWith('√')) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
      // }
      if (operatorRegx.hasMatch(_expression)) {
        _expression = _expression.substring(0, _expression.length - 1);
      }

      _expression += inputToken;
    } else if (inputToken.compareTo(')') == 0 ||
        inputToken.compareTo('(') == 0) {
      _expression += inputToken;
    } else if (angleRegx.hasMatch(inputToken)) {
      _expression += RegExp(r'\d$').hasMatch(_expression)
          ? '*$inputToken'
          : inputToken;
    } else if (inputToken == '!') {
      if (operatorRegx.hasMatch(_expression) ||
          endsWithRootOrFactorial.hasMatch(_expression)) {
        _expression =
            "${_expression.substring(0, _expression.length - 1)}$inputToken"; //Todo:replace Operation
      } else {
        _expression += inputToken;
      }
    }
    //
    //Todo: if User input is root//
    else if (inputToken.contains('√')) {
      _expression += inputToken;
    }
    //***************************percentage***************************** */
    else if (inputToken == '%') {
      if (operatorRegx.hasMatch(_expression)) {
        return;
      } else {
        _expression += "%";
      }
    }
    // factorial
    else if (inputToken == '^') {
      if (operatorRegx.hasMatch(_expression)) {
        _expression =
            _expression.substring(0, _expression.length - 1) + inputToken;
      } else {
        _expression += inputToken;
      }
    } else if (inputToken == '1/x') {
      _expression += '^(-1)';
    } else {
      _expression += inputToken;
    }
    notifyListeners();
  }

  void evlauteEndExpressionResult(String inputExpression) {
    try {
      String input = _validateExpression(inputExpression);
      input = _handleBalanceParentheses(input);
      String historyInput = input;
      input = normalizeFactorialExponent(input);

      input = normalizeRootSymbols(input.trim());

      input = processImplicitMultiplication(_handleBalanceParentheses(input));

      input = input.replaceAll('e', '${math.e}');
      input = input.replaceAll('π', '${math.pi}');

      input = normalizeDegrees(input);
      input = processImplicitMultiplication(input);
     

      final resultPersantage = processImplicitMultiplication(
        evaluatePercentageExpression(input),
      );
 debugPrint('processImplicitMultiplication is ----resultPersantage $resultPersantage');
      final evlauteExpression = _parser.parse(resultPersantage);

      //Todo: Evaluate expression:
      var evaluator = RealEvaluator(_contextModel);

      num resultExpression = evaluator.evaluate(evlauteExpression);

      // resultsEvaluator = resultExpression.toString();

      resultsEvaluator = inverseAngleRegx.hasMatch(input)
          ? '${_formatResult(num.parse(resultExpression.toString()).toDouble().toDegrees())}°'
          : _formatResult(num.parse(resultExpression.toString()));

      _saveCalculationHistoryResults(
        historyInput,
       resultsEvaluator.toString(),
      );

      notifyListeners();
    } on FormatException {
      resultsEvaluator = "Invalid Format";
      notifyListeners();
    } on UnsupportedError {
      resultsEvaluator = ' Can\'t divide by 0';
      notifyListeners();
    } on ArgumentError {
      resultsEvaluator = "Invalid input";
      notifyListeners();
    } catch (e) {
      resultsEvaluator = "Unexpected error";
      notifyListeners();
    }
  }

  String _formatResult(num value) {
    const epsilon = 1e-12;
    if ((value - value.roundToDouble()).abs() < epsilon) {
      return value.round().toString();
    }

    String result = value.toStringAsPrecision(12);
    result = result
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');

    return result.toString();
  }

  void _saveCalculationHistoryResults(String input, String resultExpression) {
    final historyItem = HistoryItem(
      expression: input,
      result: resultExpression,
      dateTime: DateTime.now(),
    );
    HistoryProvider.addCalculation(historyItem);
  }

  String _validateExpression(String inputExpression) {
    String input = inputExpression;

    RegExp(r'[+-]$').hasMatch(input) ? input += "0" : input;
    RegExp(r'[*/]$').hasMatch(input) ? input += "1" : input;

    bool isValidExpression = true;

    if (input.startsWith(')') ||
        input.endsWith('^') ||
        hasOperatorBeforeCloseParen.hasMatch(input) ||
        !RegExp(r'(\d+|e|π)').hasMatch(input)) {
      isValidExpression = false;
    }

    if (!isValidExpression || RegExp(r'\(%').hasMatch(input)) {
      throw FormatException('Error Formate');
    }
    return input;
  }

  String _normalizeCurrentInputExpression(String currentInputExpression) {
    return currentInputExpression
        .replaceAll("x!", "!")
        .replaceAll("xʸ", "^")
        .replaceAll('−', '-')
        .replaceAll('√x', '√')
        .replaceAll(RegExp(r'^x'), "*")
        .replaceAll('÷', '/')
        .replaceAll('sin⁻¹', 'arcsin')
        .replaceAll('cos⁻¹', 'arccos')
        .replaceAll('tan⁻¹', 'arctan')
        .replaceAllMapped(angleRegx, (m) => "${m[0]}(")
        .replaceAllMapped(loglnReg, (m) => "${m[0]}(");
  }

  String _handleBalanceParentheses(String input) {
    final token = StringBuffer();
    int openParentheses = 0;
    for (var i = 0; i < input.length; i++) {
      final char = input[i];

      if (char == '(') {
        openParentheses++;
        token.write(char);
      } else if (char == ')') {
        if (openParentheses > 0) {
          openParentheses--;
          token.write(char);
        }
        //ignore extra opening parentheses;
      } else {
        token.write(char);
      }
      //in
    }
    if (openParentheses > 0) token.write(")" * openParentheses);
    return token.toString();
  }

  String evaluatePercentageExpression(String input) {
    if (!input.contains('%')) return input;

    String expression = input;

    // step 1: Handle powers with percent exponent (simple numbers)

    expression = expression.replaceAllMapped(
      RegExp(r'(\^)(\d+(\.\d+)?)%'),
      (match) => '${match[1]}(${match[2]}*0.01)',
    );

    // step 2: Handle powers with percent exponent (parenthesized expressions)

    expression = expression.replaceAllMapped(
      RegExp(r'(\^\(+)([^)]+\)+)%'),
      (match) => '${match[1]}(${match[2]}*0.01)',
    );

    // step 3: Handle factorial-percentage combinations

    expression = expression.replaceAllMapped(
      RegExp(r'((?<!^)!)(%)(\d+(\.\d+)?)'),
      (match) => '${match[1]}*0.01*${match[3]}',
    );
    expression = expression.replaceAllMapped(
      RegExp(r'((?<!^)!)(%)'),
      (match) => '${match[1]}*0.01',
    );

    // step 4: Convert regular percent to multiplication by 0.01

    final regularPercentRegex = RegExp(r'%(?![-+)])(?!$)');
    expression = expression.replaceAll(regularPercentRegex, '*0.01');

    // step 5: Handle percent right before closing parenthesis

    expression = expression.replaceAll(RegExp(r'\)%'), ')*0.01');

    // step 6: Handle percent after opening parenthesis

    expression = expression.replaceAllMapped(
      RegExp(r'(\(+\d+(\.\d+)?)(%)'),
      (match) => '${match[1]}*0.01',
    );

    // step 7:  evaluation of remaining complex percentages
    return _evaluateComplexPercentages(expression);
  }

  ///  evaluates complex percentage expressions
  String _evaluateComplexPercentages(String input) {
    String leftOfPercent = '';
    String processedResult = '';
    int scanIndex = 0;

    Map<int, String> expressionVersions = {};
    int versionCount = 0;
    expressionVersions[versionCount] = input;

    if (expressionVersions[versionCount]!.split('%').length < 2) {
      return expressionVersions[versionCount]!;
    }

    while (scanIndex < expressionVersions[versionCount]!.length) {
      if (expressionVersions[versionCount]![scanIndex] == '%') {
        leftOfPercent = expressionVersions[versionCount]!.substring(
          0,
          scanIndex + 1,
        );

        final numberBeforePercent = RegExp(
          r'(\d+(\.\d+)?\!*)(%)',
        ).firstMatch(leftOfPercent);

        if (numberBeforePercent == null) {
          scanIndex++;
          continue;
        }

        String leftExpression = leftOfPercent.substring(
          0,
          math.max(numberBeforePercent.start - 1, 0),
        );
        //Find where the expression that this % applies to begins
        //Walk backwards until parentheses balance (to capture full sub-expression)
        int openParenCount = 0, closeParenCount = 0, breakIndex = 0;
        for (int j = leftExpression.length - 1; j >= 0; j--) {
          if (leftExpression[j] == ')') closeParenCount++;
          if (leftExpression[j] == '(') openParenCount++;
          if (openParenCount > closeParenCount) break;
          breakIndex = j;
        }
        // Split into: part before the targeted expression, and the expression itself
        final beforeTargetExpr = leftExpression.substring(0, breakIndex);
        final leftPercentageOperations = leftExpression.substring(breakIndex);

        String leftPercentageOPerator = '';
        if (leftExpression.isNotEmpty) {
          leftPercentageOPerator =
              RegExp(r'[*/]$').hasMatch(
                leftOfPercent.substring(
                  leftExpression.length,
                  numberBeforePercent.start,
                ),
              )
              ? leftOfPercent.substring(
                  leftExpression.length,
                  numberBeforePercent.start,
                )
              : '';
        }

        String percentValue = leftOfPercent.substring(
          numberBeforePercent.start,
          numberBeforePercent.end,
        );
        percentValue = percentValue.replaceAll('%', '*0.01');
        percentValue = solveExpression(percentValue);

        final percentResult = solveExpression(
          '(${leftPercentageOperations.isEmpty ? '1' : leftPercentageOperations})'
          '${leftPercentageOPerator.isNotEmpty ? leftPercentageOPerator : '*'}'
          '$percentValue',
        );

        final combinedResult =
            (breakIndex == numberBeforePercent.start ||
                leftPercentageOPerator.isNotEmpty)
            ? percentResult
            : solveExpression(
                '${leftOfPercent.substring(breakIndex, numberBeforePercent.start)}$percentResult',
              );

        processedResult = expressionVersions[versionCount]!.substring(
          (leftOfPercent.length),
        );
        processedResult =
            '${beforeTargetExpr.trim()}$combinedResult$processedResult';

        versionCount++;
        expressionVersions[versionCount] = processedResult;
        scanIndex = 0;
        continue;
      }

      scanIndex++;
    }

    return expressionVersions[versionCount]!;
  }

  String solveExpression(String str) {
    try {
      final realEvaluator = RealEvaluator(_contextModel);

      Expression strExpression = _parser.parse(str);

      final result = realEvaluator.evaluate(strExpression);
      return result.toString();
    } catch (e) {
      rethrow;
    }
  }

  set setExpression(String expr) {
    _expression = expr;
    notifyListeners();
  }

  String get getExpression => _expression;
  void clearExpression() {
    resultsEvaluator = '';
    _expression = '';
    notifyListeners();
  }

  void removeLastCharacter() {
    final patternAngele = RegExp(r'(ln|lg|sin|acos|atan|sin|cos|tan)\($');
    final patternDeg = RegExp(r'(\d{2,})°$');
    final patternLastOperatorDeg = RegExp(r'(\d{1})°$');
    if (_expression.isEmpty) return;
    if (patternAngele.hasMatch(_expression)) {
      final afterRemove = _expression.substring(
        0,

        patternAngele.firstMatch(_expression)!.start,
      );
      _expression = afterRemove;
      resultsEvaluator = ''; //Remove last resultsEvaluator
      notifyListeners();
      return;
    } else if (patternDeg.hasMatch(_expression)) {
      _expression = _expression.substring(
        0,

        patternDeg.firstMatch(_expression)!.end - 2,
      );
      _expression += '°';
      resultsEvaluator = ''; //Remove last resultsEvaluator
      notifyListeners();
    } else if (patternLastOperatorDeg.hasMatch(_expression)) {
      _expression = _expression.substring(
        0,

        patternLastOperatorDeg.firstMatch(_expression)!.end - 2,
      );

      resultsEvaluator = ''; //Remove last resultsEvaluator
      notifyListeners();
    } else {
      resultsEvaluator = '';
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
      return;
    }
  }

  String get getResultsEvaluator => resultsEvaluator;
}
