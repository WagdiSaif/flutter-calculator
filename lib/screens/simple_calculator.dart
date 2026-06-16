import 'package:calculator/apptheme/theme.dart';

import 'package:calculator/provider/calculator_setting.dart';
import 'package:calculator/provider/expression_evaluator.dart';

import 'package:calculator/screens/header_calclutor.dart';
import 'package:calculator/screens/scientific_calculator.dart';
import 'package:calculator/utils/extention.dart';

import 'package:calculator/widgets/equals_button.dart';
import 'package:calculator/widgets/mode_switch_button.dart';
import 'package:calculator/widgets/number_button.dart';
import 'package:calculator/widgets/operation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//todo:Enter :

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  final _scrollController = ScrollController();
  final GlobalKey _headerKey = GlobalKey();
  final GlobalKey _keypadKey = GlobalKey();
  final GlobalKey globalKeyScrolling = GlobalKey();
  RenderBox? _headerRenderBox;
  RenderBox? _keypadRenderBox;
  late final CalculatorSetting _calculatorSetting;
  Future<void> _enureVisibleRelatedWidget(
    PointerUpEvent event,
    CalculatorSetting calSetting,
    Offset globalPostion,
  ) async {
    _calculatorSetting.changeScrollScreenState(true);

    if (headerGlobalPosition != null) {
      final heightScrollingKeypad = calSetting.isScientificMode
          ? ((_scrollingKeypadHeight!) * 0.95)
          : (_scrollingKeypadHeight!) * (1.10);
      if (headerGlobalPosition! >= heightScrollingKeypad) {
        if (_scrollController.position.extentBefore < heightScrollingKeypad) {
          await _scrollController.position.ensureVisible(
            _headerRenderBox!,
            duration: Duration(milliseconds: 300),
            curve: Curves.bounceInOut,
          );
        }
      } else {
        await _scrollController.position.ensureVisible(
          _keypadRenderBox!,
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
      }
    }
  }

  double? _scrollingKeypadHeight;
  @override
  void initState() {
    super.initState();
    _calculatorSetting = Provider.of<CalculatorSetting>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _headerRenderBox =
          _headerKey.currentContext?.findRenderObject() as RenderBox;
      _keypadRenderBox =
          _keypadKey.currentContext?.findRenderObject() as RenderBox;

      _scrollController.addListener(() {
        headerGlobalPosition = (_keypadRenderBox!.localToGlobal(Offset.zero).dy)
            .abs();
        _scrollingKeypadHeight = _keypadRenderBox!.size.height;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    _calculatorSetting.dispose();

    super.dispose();
  }

  Future<void> _checkHeaderScrollingPosition(Offset globalPostion) async {
    if (_keypadRenderBox == null) return;

    final keypadGlobalPostion = _keypadRenderBox!.localToGlobal(Offset.zero);

    final isPointerOnCalculatorHeaderWidget =
        globalPostion.dy <=
            ((keypadGlobalPostion.dy) + (_keypadRenderBox!.size.height)) &&
        globalPostion.dy <= keypadGlobalPostion.dy;

    if (isPointerOnCalculatorHeaderWidget) {
      _calculatorSetting.changeScrollScreenState(true);
    } else {
      _calculatorSetting.changeScrollScreenState(false);
    }

    return;
  }

  double? headerGlobalPosition;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<CalculatorSetting>(
            builder: (context, calSetting, _) {
              return Listener(
                onPointerUp: (event) async {
                  await _enureVisibleRelatedWidget(
                    event,
                    calSetting,
                    event.position,
                  );
                },
                onPointerDown: (event) {
                  _checkHeaderScrollingPosition(event.position);
                },

                onPointerCancel: (event) {
                  _calculatorSetting.changeScrollScreenState(true);
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: calSetting.isScreenScrollingState
                      ? AlwaysScrollableScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  reverse: true,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.0, top: 0.0),
                    child: Column(
                      //  mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        HeaderCalclutor(globalKey: _headerKey),

                        calSetting.isScientificMode
                            ? ScientificCalculator(
                                keypadKey: _keypadKey,
                                calculatorSetting: calSetting,
                              )
                            : Column(
                                key: _keypadKey,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Divider(),

                                  Row(
                                    children: [
                                      Selector<ExpressionEvaluator, String>(
                                        selector: (context, obj) =>
                                            obj.getExpression,
                                        builder: (context, value, child) {
                                          return OperationButton(
                                            onPressedfun: () => context
                                                .read<ExpressionEvaluator>()
                                                .clearExpression(),
                                            btntext: value.isEmpty ? 'AC' : 'C',
                                          );
                                        },
                                      ),
                                      OperationButton(
                                        onPressedfun: () => context
                                            .read<ExpressionEvaluator>()
                                            .removeLastCharacter(),
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
                                      NumberButton(
                                        btntext: '7',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      NumberButton(
                                        btntext: '8',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      NumberButton(
                                        btntext: '9',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      OperationButton(
                                        // color: Colors.grey.shade100,
                                        btntext: 'x',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      NumberButton(
                                        btntext: '4',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      NumberButton(
                                        btntext: '5',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      NumberButton(
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                        btntext: '6',
                                      ),
                                      OperationButton(
                                        textStyle: appTheme
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(fontSize: 11.sw(context)),
                                        // color: Colors.grey.shade100,
                                        btntext: '−',
                                      ),
                                    ],
                                  ),

                                  //kk
                                  Row(
                                    children: [
                                      NumberButton(
                                        btntext: '1',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      NumberButton(
                                        btntext: '2',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      NumberButton(
                                        btntext: '3',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      OperationButton(
                                        // color: Colors.grey.shade100,
                                        btntext: '+',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ModeSwitchButton(
                                        changeCalculatorMode: () {
                                          calSetting.setScientificMode =
                                              !(calSetting.isScientificMode);
                                        },

                                        // btntext: '+/-',
                                      ),
                                      NumberButton(
                                        btntext: '0',
                                        textStyle:
                                            appTheme.textTheme.displayMedium!,
                                      ),
                                      NumberButton(
                                        isCustomChar: true,
                                        btntext: '.',
                                        textStyle: appTheme
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(fontSize: 10.sw(context)),
                                      ),
                                      Selector<ExpressionEvaluator, String>(
                                        selector: (_, expressionEvaluator) =>
                                            expressionEvaluator.getExpression,

                                        builder:
                                            (context, expreesionValue, child) {
                                              return EqualsButton(
                                                onPressedEquals: () {
                                                  context
                                                      .read<
                                                        ExpressionEvaluator
                                                      >()
                                                      .evalauteExpression(
                                                        expreesionValue,
                                                      );
                                                },
                                              );
                                            },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                        //the second
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
