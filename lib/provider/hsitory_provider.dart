import 'package:calculator/model/history_item.dart';

import 'package:hive/hive.dart';

class HistoryProvider{
static Box<HistoryItem>? _hiveBox;

static Box<HistoryItem> get instance => _hiveBox ?? Hive.box<HistoryItem>('HistoryItem');
 static void addCalculation(HistoryItem historyItem) async {
 await instance.add(historyItem);
}
static List<HistoryItem> get getHistoryItem {
  return instance.values.toList()..sort((a, b) => b.dateTime.compareTo(a.dateTime));

}

void retriveHistory() {
 final history= instance.values.toList();
 history.sort((a, b) => b.dateTime.compareTo(a.dateTime));


}
 static Future<void> deleteHistory()async{
 await  instance.clear();

}



}