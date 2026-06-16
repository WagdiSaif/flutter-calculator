import 'package:calculator/apptheme/theme.dart';
import 'package:calculator/model/history_item.dart';
import 'package:calculator/provider/expression_evaluator.dart';
import 'package:calculator/provider/hsitory_provider.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:calculator/core/extention.dart';

class HeaderCalclutor extends StatelessWidget {
  HeaderCalclutor({required this.globalKey, super.key});

  final GlobalKey globalKey;

  final hiveBox = HistoryProvider.instance.listenable();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      decoration: BoxDecoration(),
      constraints: BoxConstraints(
        minHeight: 100.sh(context),
        maxHeight: double.infinity,
        minWidth: 100.sw(context),
      ),
      padding: EdgeInsets.all(5),

      alignment: Alignment.bottomRight,
      width: (100).sw(context),
      child: Column(
        children: [
          ValueListenableBuilder<Box<HistoryItem>>(
            valueListenable: hiveBox,
            builder: (context, box, _) {
              final items = box.values.toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (items.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          items.length,
                          (index) => Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '  ${items[index].expression} ',
                                  style: appTheme.textTheme.bodySmall,
                                ),
                                Text(
                                  '= ${items[index].result.toString()}',
                                  style: appTheme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                  ],
                ),
              );
            },
          ),

          Container(
            padding: EdgeInsets.all(9),

            alignment: Alignment.centerRight,
            width: (100).sw(context),

            child: Selector<ExpressionEvaluator, (String, String)>(
              selector: (context, expr) =>
                  (expr.getExpression, expr.getResultsEvaluator),
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //Show Expression
                    value.$2.isEmpty
                        ? Text(
                            value.$1.isEmpty
                                ? "0"
                                : value.$1
                                      .replaceAll('*', 'x')
                                      .replaceAll("/", "÷"),
                            style: appTheme.textTheme.displayLarge,
                            maxLines: 1,
                          )
                        : SizedBox(),
                    value.$2.isNotEmpty ? SizedBox(height: 10) : SizedBox(),

                    //Show Results
                    value.$2.isNotEmpty
                        ? Text(
                            value.$2,
                            style: appTheme.textTheme.displayLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
