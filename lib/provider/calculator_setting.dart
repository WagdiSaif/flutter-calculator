import 'package:flutter/material.dart';

class CalculatorSetting extends ChangeNotifier {
  static CalculatorSetting? _instance;

  late bool modeThemeState;
  late bool _isScrollScreen;

  CalculatorSetting._initSetting()
    : _isScrollScreen = false,
      modeThemeState = true;

  bool get isScreenScrollingState => _isScrollScreen;
  static CalculatorSetting get instance =>
      _instance ?? CalculatorSetting._initSetting();

  void changeScrollScreenState(bool scroll) {
    _isScrollScreen = scroll;
    notifyListeners();
  }
}
