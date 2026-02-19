import 'package:calculator/model/history_item.dart';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

class CalculatorSetting extends ChangeNotifier {
  static final hiveBoxAppTheme = Hive.box<bool>('ThemeState');
  static CalculatorSetting? _instance;
  static CalculatorSetting get instance =>
      _instance ?? CalculatorSetting._initSetting();
  factory CalculatorSetting() {
    return instance;
  }
  CalculatorSetting._initSetting()
    : _isScrollScreen = false,
      _isScientificMode = false,
      _isDegree = false,
      _secondMode = false;

  late bool _isScrollScreen;
  late bool _isScientificMode;
  late bool _isDegree;
  late bool _secondMode;
  bool _themeStateLight = false;

  bool get isLightModeThemeState =>
      hiveBoxAppTheme.get('themeMode') ?? _themeStateLight;

  bool get checkIsDegree => _isDegree;
  void updateDegreeRadian(bool value) {
    _isDegree = !value;
    notifyListeners();
  }

  Future<void> updateThemeModeState() async {
    _themeStateLight = hiveBoxAppTheme.get('themeMode') ?? _themeStateLight;
    _themeStateLight = !_themeStateLight;

    await hiveBoxAppTheme.put('themeMode', _themeStateLight);

    notifyListeners();
  }

  void updatetSecondMode(bool value) {
    _secondMode = !value;
    notifyListeners();
  }

  bool get getSecondMode => _secondMode;
  bool get isScientificMode => _isScientificMode;
  set setScientificMode(bool value) {
    _isScientificMode = value;
    notifyListeners();
  }

  bool get isScreenScrollingState => _isScrollScreen;

  void changeScrollScreenState(bool scroll) {
    _isScrollScreen = scroll;
    notifyListeners();
  }

  static Future<void> init() async {
    Hive.registerAdapter(HistoryItemAdapter());
    await Hive.openBox<HistoryItem>('HistoryItems');
    await Hive.openBox<bool>('ThemeState');
  }

 
}
