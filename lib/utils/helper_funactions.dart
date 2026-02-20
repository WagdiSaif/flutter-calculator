String processImplicitMultiplication(String str) {
  final patterns = [
    RegExp(r'(\d+[!%])(\d+)'),
    RegExp(r'(!)(sqrt)'),
    RegExp(r'(\d+)(\()'), // digit before (
    RegExp(r'(\))(\d+)'), // ) before digit
    RegExp(r'(\d+|%|\))(sin|cos|tan|sqrt|lg|ln)'), // digit before function
    RegExp(r'(\)|!|%)(\(+)'), // ) before (
  ];

  for (final pattern in patterns) {
    str = str.replaceAllMapped(pattern, (m) => "${m[1]}*${m[2]}");
  }
  str = str.replaceAllMapped(RegExp(r'(?<!\d+)\.'), (m) => "0${m[0]}"); //0.
  //3-4(2-3).ln(2)

  str = str.replaceAllMapped(RegExp(r'(\))(\.)'), (m) => "${m[1]}*0${m[2]}");

  str = str.replaceAllMapped(RegExp(r'(\.)(\D)'), (m) => "*${m[2]}");
  str = str
      .replaceAllMapped(RegExp(r'([πe](?![\*-/+\^)]|$))'), (m) => "${m[1]}*")
      .replaceAllMapped(
        RegExp(r'((?<![\*-/+\^(!]|^)[πe])'),
        (m) => "*${m[1]}",
      ); //regExp PiFollowed ByNot Operations

  return str;
}

String normalizeRootSymbols(String expression) {
  if (!expression.contains('√')) return expression;
  int i = 0;
  StringBuffer normalized = StringBuffer();
  int rootParenthesesCount = 0;
  while (i < expression.length) {
    final char = expression[i];
    if (char == '√') {
      int j = i + 1;
      if (j < expression.length) {
        if (expression[j] == '(') {
          j++;
          int balance = 1;

          while (balance > 0 && j < expression.length) {
            if (expression[j] == '(') balance++;
            if (expression[j] == ')') balance--;
            if (expression[j] == '√') break; //foundNestedRoot

            j++;
          }
          final subString = expression.substring(i + 1, j);

          normalized.write('sqrt$subString');

          i = j;
        } else {
          int balance = 1;
          bool foundNestedRoot = false;
          //deal with numbering and dot expression °
          if (RegExp(r'(\d|\.)').hasMatch(expression[j])) {
            while (j < expression.length) {
              if (!RegExp(r'(\d|\.)').hasMatch(expression[j])) break;
              j++;
            }
          } else {
            //deal with expresion like angle,ln,log if any
            //
            while (balance > 0 && j < expression.length) {
              if (expression[j] == '(') balance++;
              if (expression[j] == ')') balance--;
              if (expression[j] == '√') {
                foundNestedRoot = true;
                break;
              }

              j++;
            }
          }
          rootParenthesesCount = foundNestedRoot
              ? ++rootParenthesesCount
              : rootParenthesesCount; //to trace Paranthes

          normalized.write(
            foundNestedRoot
                ? 'sqrt(${expression.substring(i + 1, j)}'
                : 'sqrt(${expression.substring(i + 1, j)})', //i+1 to skip √
          );

          i = j;
        }
      }
    } else {
      normalized.write(')' * rootParenthesesCount);
      rootParenthesesCount = 0;
      normalized.write(char);
      i++;
    }
  }

  normalized.write(')' * rootParenthesesCount);
  return normalized.toString();
}

//Handl Factorial Followed by Power
String normalizeFactorialExponent(String exp) {
  exp = exp.replaceAllMapped(
    RegExp(r'(\^)([-+])(\d+(\.\d+)?)'),
    (match) => '${match[1]}(${match[2]}${match[3]})',
  );
  Iterable<Match> factorialExponentMatches = RegExp(r'(!\^)').allMatches(exp);

  List<String> normalizedParts = [];
  int currentMatchIndex = -1;
  if (factorialExponentMatches.isEmpty) return exp;
  for (Match matchExp in factorialExponentMatches) {
    currentMatchIndex++;
    final expressionBeforeExponent = exp.substring(0, matchExp.end - 1);

    final leftFactorialSymbol = expressionBeforeExponent.substring(
      expressionBeforeExponent.length - 2,
      expressionBeforeExponent.length - 1,
    );

    // Extract the base expression that needs to be factorialized
    String factorialBase = '';
    for (var i = expressionBeforeExponent.length - 2; i >= 0; i--) {
      //
      final char = expressionBeforeExponent[i];

      if (char == '(') {
        //check is (
        final leftOpenParanthesExp = expressionBeforeExponent.substring(
          0,
          i + 1,
        ); //if it ( the extratct exp from start until parentheses

        if (!RegExp(r'[\d+\-*/]\(+$').hasMatch(leftOpenParanthesExp) &&
            leftFactorialSymbol == ')') {
          for (var element in leftOpenParanthesExp.split('').reversed) {
            if (RegExp(r'[\d++\-*/\)]').hasMatch(element)) break;

            factorialBase = element + factorialBase;
          }

          break;
        } else {
          break;
        }
      } else {
        if (leftFactorialSymbol != ')') {
          if (!RegExp(r'(\d+|\.|\)|π|e)').hasMatch(char)) {
            break;
          }
          factorialBase = char + factorialBase;
        } else {
          factorialBase = char + factorialBase;
        }
      }
    }
    //The following to mak normliz for each substring contain !^
    final expressionWithoutBase = expressionBeforeExponent.substring(
      0,
      expressionBeforeExponent.length -
          (factorialBase.length +
              1), //factorialBase.length + 1 because factorialBase start from string after !
    );

    String processedExpression = '$expressionWithoutBase($factorialBase!)';
    // Handle overlapping matches in complex expressions

    if (normalizedParts.isNotEmpty && currentMatchIndex > 0) {
      final previousPart =
          normalizedParts[currentMatchIndex - 1]; //Return to previousPart index
      final startIndex = previousPart.length - 2;
      if (startIndex >= 0 && startIndex < processedExpression.length) {
        processedExpression = processedExpression.substring(startIndex);
      }
    }

    normalizedParts.add(processedExpression);

    // Append any remaining expression after processing all matches
    if (normalizedParts.length == factorialExponentMatches.length) {
      final remainingExpression = exp.substring(matchExp.end - 1);
      normalizedParts.add(remainingExpression);
    }
  }

  return normalizedParts.join();
}

String validTringDeg(String exp, String currentUserInput) {
  if (RegExp(r'(\d+|°)$').hasMatch(exp)) {
    if (exp.endsWith('°')) {
      return '${exp.substring(0, exp.length - 1)}$currentUserInput°';
    }
    return '$exp$currentUserInput';
  }
  if (RegExp(r'[*/)]$').hasMatch(exp)) {
    return '$exp$currentUserInput';
  }

  final trigMatch = RegExp(r'\b(sin|cos|tan)\b\(+').firstMatch(exp);

  int openParenthesesCount = RegExp(r'\(').allMatches(exp).length;
  int closeParenthesesCount = RegExp(r'\)').allMatches(exp).length;
  if (trigMatch == null || closeParenthesesCount == openParenthesesCount) {
    return '$exp$currentUserInput';
  }

  int breakIndex = 0;
  int open = 0;
  int close = 0;
  for (var i = exp.length - 1; i >= 0; i--) {
    if (exp[i] == ')') close++;
    if (exp[i] == '(') {
      open++;
    }
    if (open > close) {
      breakIndex = i;
      break;
    }
  }

  final prefix = exp.substring(0, breakIndex);

  final isTrigParenthesis = RegExp(r'((sin|cos|tan)\(*)$').hasMatch(prefix);
  if (isTrigParenthesis) {
    return '$exp$currentUserInput°';
  } else {
    return '$exp$currentUserInput';
  }
}

(String, bool) shouldApplyPercentageToTrigArgument(
  String exp, [
  String currentUserInput = '%',
]) {
  int openParenthesesCount = RegExp(r'\(').allMatches(exp).length;
  int closeParenthesesCount = RegExp(r'\)').allMatches(exp).length;
  if (closeParenthesesCount == openParenthesesCount) {
    return (exp, false);
  }
  final matchAngle = RegExp(r'.*?(sin|cos|tan)\(+').firstMatch(exp);

  if (matchAngle == null) {
    return (exp, false);
  }
  int breakIndex = 0;
  int open = 0;
  int close = 0;
  for (var i = exp.length - 1; i >= 0; i--) {
    if (exp[i] == ')') close++;
    if (exp[i] == '(') {
      open++;
    }
    if (open > close) {
      breakIndex = i;
      break;
    }
  }
  final prefix = exp.substring(0, breakIndex);

  final isTrigParenthesis = RegExp(r'((sin|cos|tan)\(*)$').hasMatch(prefix);
  if (isTrigParenthesis) {
    exp = '$exp$currentUserInput';
    return (exp, true);
  } else {
    return (exp, false);
  }
}

String normalizeDegrees(String input) {
  if (!input.contains('°')) return input;
  return input.replaceAllMapped(
    RegExp(r'((sqrt\()?(\d+|e)(\.\d+)?\)?)°'),
    (m) => 'DEG(${m[1]})',
  );
}
