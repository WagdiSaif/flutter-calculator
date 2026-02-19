import 'dart:math' as math;

import 'package:flutter/material.dart';

extension BuildContextSizer on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}
extension ResponsiveSize on double {
double sh(BuildContext context) => (this / 100) * (context.screenHeight);
double sw(BuildContext context) => (this / 100) * (context.screenWidth);
}
extension ConvertTodegrees on double {
  double toDegrees() {
    return double.parse((this * (180 / math.pi)).toStringAsFixed(2));
  }
}

