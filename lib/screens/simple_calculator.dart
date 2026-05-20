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
  final GlobalKey _firstListener = GlobalKey();
  final GlobalKey _secondListener = GlobalKey();
  final GlobalKey globalKeyScrolling = GlobalKey();
  RenderBox? headerRenderBox;
  RenderBox? keyBordRenderBox;
  late final CalculatorSetting _calculatorSetting;
  Future<void> _enureVisibleRelatedWidget(
    PointerUpEvent event,
    CalculatorSetting calSetting,
  ) async {
    _calculatorSetting.changeScrollScreenState(true);
    //scrollingKeybordHeight

    if (headerGlobalPosition != null) {
      final heightScrollingKeyBoard = calSetting.isScientificMode
          ? ((scrollingKeybordHeight!) - scrollingKeybordHeight! * .05)
          : ((scrollingKeybordHeight!) + scrollingKeybordHeight! * .10);
      if (headerGlobalPosition! >= heightScrollingKeyBoard) {
        await _scrollController.position.ensureVisible(
          headerRenderBox!,
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
      } else {
        await _scrollController.position.ensureVisible(
          keyBordRenderBox!,
          duration: Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
      }
    }
  }

  double? scrollingKeybordHeight;
  @override
  void initState() {
    super.initState();
    _calculatorSetting = Provider.of<CalculatorSetting>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerRenderBox =
          _firstListener.currentContext?.findRenderObject() as RenderBox;
      keyBordRenderBox =
          _secondListener.currentContext?.findRenderObject() as RenderBox;

      _scrollController.addListener(() {
        headerGlobalPosition = (keyBordRenderBox!.localToGlobal(Offset.zero).dy)
            .abs();
        scrollingKeybordHeight = keyBordRenderBox!.size.height;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Future<void> _checkHeaderScrollingPosition(Offset globalPostion) async {
    if (keyBordRenderBox == null) return;

    final keyBordGlobalPostion = keyBordRenderBox!.localToGlobal(Offset.zero);

    final isPointerOnCalculatorHeaserWidget =
        globalPostion.dy <=
            ((keyBordGlobalPostion.dy) + (keyBordRenderBox!.size.height)) &&
        globalPostion.dy <= keyBordGlobalPostion.dy;

    if (isPointerOnCalculatorHeaserWidget) {
      _calculatorSetting.changeScrollScreenState(true);
    } else {
      _calculatorSetting.changeScrollScreenState(false);
    }

    //todo: here do
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
                  await _enureVisibleRelatedWidget(event, calSetting);
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
                        HeaderCalclutor(globalKey: _firstListener),

                        calSetting.isScientificMode
                            ? ScientificCalculator(
                                keyBoardKey: _secondListener,
                                calculatorSetting: calSetting,
                              )
                            : Column(
                                key: _secondListener,
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
                                            .copyWith(
                                              fontSize: 11.sw(context),
                                            ),
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
                                            .copyWith(
                                              fontSize: 10.sw(context),
                                            ),
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
                                                      .evlauteEndExpressionResult(
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
