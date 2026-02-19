import 'package:calculator/provider/hsitory_provider.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () async {

       await   HistoryProvider.deleteHistory();
       if(context.mounted) Navigator.pop(context);
      
   
        }, icon: Icon(Icons.delete)),
        title: const Text('history'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        reverse: true,
        child: Container(
          alignment: Alignment.centerRight,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ...HistoryProvider.getHistoryItem.map(
                (e) => Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text('${e.expression}'), Text('${e.result}')],
                  ),
                ),
              ),
              Text(''),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
