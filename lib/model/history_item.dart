import 'dart:core';

import 'package:hive/hive.dart';
part 'history_item.g.dart';

@HiveType(typeId: 0)
class HistoryItem extends HiveObject {
  @HiveField(0)
  final String expression;

  @HiveField(1)
  final String result;

  @HiveField(2)
  final DateTime dateTime;

  HistoryItem({
    required this.expression,
    required this.result,
    required this.dateTime,
  });
}
