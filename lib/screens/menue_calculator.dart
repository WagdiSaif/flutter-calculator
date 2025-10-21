import 'package:calculator/apptheme/theme.dart';
import 'package:calculator/provider/exprisson_result.dart';
import 'package:calculator/provider/calculator_setting.dart';
import 'package:calculator/screens/header_calclutor.dart';
import 'package:calculator/widgets/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenueCalculator  extends StatefulWidget{
  const MenueCalculator({super.key});

  @override
  State<MenueCalculator> createState() => _MenueCalculatorState();
}

class _MenueCalculatorState extends State<MenueCalculator> {
   final _scrollController = ScrollController();
  final GlobalKey _firstListener = GlobalKey();
  final GlobalKey _secondListener = GlobalKey();
  final GlobalKey globalKeyScrolling = GlobalKey();
  RenderBox? headerRenderBox;
  RenderBox? keyBordRenderBox;
  late final CalculatorSetting _calculatorSetting;

  @override
  void initState() {
    //hide item 100
    super.initState();
    _calculatorSetting = Provider.of<CalculatorSetting>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      headerRenderBox =
          _firstListener.currentContext?.findRenderObject() as RenderBox;
      keyBordRenderBox =
          _secondListener.currentContext?.findRenderObject() as RenderBox;

      _scrollController.addListener(() {
        headerGlobalPosition = (headerRenderBox!.localToGlobal(Offset.zero).dy)
            .abs();
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
    //local=globalclick-WidgetTopIntheGlobal
    //globalclick=local+WidgetTopIntheGlobal
    //180=local+(-500)

    final isPointerOnCalculatorHeaserWidget =
        globalPostion.dy <=
            ((keyBordGlobalPostion.dy) + (keyBordRenderBox!.size.height)) &&
        globalPostion.dy <= keyBordGlobalPostion.dy;

    if (isPointerOnCalculatorHeaserWidget) {
      _calculatorSetting.changeScrollScreenState(true);
    } else {
      _calculatorSetting.changeScrollScreenState(false);
    }

    //todo: here doo
    return;
  }

  int count = 0;
  double? headerGlobalPosition;
  double screenHeight = 0.0;
  double screenWidth = 0.0;
  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    //statues bar 28

    //appbar  56
    final scrollState = context.watch<CalculatorSetting>();
    debugPrint('appbarkk ${scrollState.isScreenScrollingState}');
    return Column(
        children: [
          Expanded(
            child: Consumer<CalculatorSetting>(
              //  selector: (_,CalculatorSetting calSetting)=>calSetting.scrollScreen,
              builder: (context, calSetting, snapshot) {
                return Listener(
                  onPointerSignal: (event) async {},
                  onPointerUp: (event) async {
                    await _enureVisibleRelatedWidget(event);
                  },
                  onPointerDown: (event) {
                    _checkHeaderScrollingPosition(event.position);
                  },

                  onPointerCancel: (event) {
                    _calculatorSetting.changeScrollScreenState(true);
                  },
                  child: SingleChildScrollView(
                    // dragStartBehavior: DragStartBehavior.down,
                    controller: _scrollController,
                    physics: calSetting.isScreenScrollingState
                        ? AlwaysScrollableScrollPhysics()
                        : NeverScrollableScrollPhysics(),
                    reverse: true,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * 0.0,
                        top: 0.0,
                      ),
                      child: Column(
                        //  mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          HeaderCalclutor(
                            globalKey: _firstListener,
                            width: screenWidth,
                            height: screenHeight,
                          ),

                          Container(
                            key: _secondListener,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Divider(
                                  thickness: 2,
                                  height: 9,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),

                                Row(
                                  children: [
                                    MainButton(
                                  textStyle: appTheme.textTheme.displaySmall,
                                      onPressed: () {
                                        context
                                            .read<ExpressionResult>()
                                            .clearExpression();
                                      },
                                      // color: Colors.grey.shade100,
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: 'C',

                                    ),
                                    MainButton(
                                      // color: Colors.grey.shade100,
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '⌫',
                                        textStyle: appTheme.textTheme.displaySmall,
                                      onPressed: () {
                                        String expr = context
                                            .read<ExpressionResult>()
                                            .getExperssion;
                                        expr = expr.replaceFirst(
                                          RegExp(r'.$'),
                                          '',
                                          expr.length - 1,
                                        );
                                        context
                                                .read<ExpressionResult>()
                                                .setExpression =
                                            expr;
                                      },
                                    ),
                                    MainButton(
                                      // color: Colors.grey.shade100,
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '%',
                                        textStyle: appTheme.textTheme.displaySmall,
                                    ),
                                    MainButton(
                                      // color: Colors.grey.shade100,
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '÷',
                                        textStyle: appTheme.textTheme.displaySmall,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '7',  textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '8',  textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '9',
                                        textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      // color: Colors.grey.shade100,
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: 'x',  textStyle: appTheme.textTheme.displaySmall,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '4', textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '5',
                                        textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                        textStyle: appTheme.textTheme.displayMedium,
                                      btntext: '6',
                                    ),
                                    MainButton(
                                      // color: Colors.grey.shade100,
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '-',  textStyle: appTheme.textTheme.displaySmall,
                                    ),
                                  ],
                                ),

                                //kk
                                Row(
                                  children: [
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '1',
                                      textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '2',  textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '3',  textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      // color: Colors.grey.shade100,
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '+',  textStyle: appTheme.textTheme.displaySmall,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MainButton(
                                      btnWidget: IconButton(onPressed: (){
                                      //  context.read<ExpressionResult>().changExpression('+/-');
                                      }, icon:Icon(Icons.navigation_outlined,color:appTheme.textTheme.displaySmall!.color,)),
                                      width: screenWidth,
                                      height: screenHeight,
                                     // btntext: '+/-',
                                    ),
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '0', textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      width: screenWidth,
                                      height: screenHeight,
                                      btntext: '.',  textStyle: appTheme.textTheme.displayMedium,
                                    ),
                                    MainButton(
                                      btnWidget: CircleAvatar(
    backgroundColor:
                                            Theme.of(context).colorScheme.primary,
                                        child: Text('=', style: appTheme.textTheme.labelMedium!.copyWith(fontSize: screenWidth*.07),),
                                      ),
                                      onPressed: () {
                                        context
                                            .read<ExpressionResult>()
                                            .evaluateExpression();
                                      },
                                      // color: Colors.blue,
                                      width: screenWidth,
                                      height: screenHeight,
                                      textStyle: appTheme.textTheme.displaySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
      )
    ;
  }
   Future<void> _enureVisibleRelatedWidget(PointerUpEvent event) async {
    _calculatorSetting.changeScrollScreenState(true);
  
    if (headerGlobalPosition != null) {
      if (headerGlobalPosition! <= (screenHeight / 2)) {
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
}