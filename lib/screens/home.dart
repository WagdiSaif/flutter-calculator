
import 'package:calculator/screens/menue_calculator.dart';


import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
   TabController? _tabController;
  final List<Widget> _screenWidget=[MenueCalculator(),Container(color: Colors.red,height: 200,)];
   int initTab=0;
   @override
   void initState(){
    
    super.initState();
    _tabController=TabController(length: 2,vsync: this,initialIndex: initTab);

   }

 
  @override
  Widget build(BuildContext context) {
    
    

    return Scaffold(
      
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      appBar: AppBar(
        leading: PopupMenuButton(
itemBuilder: (contex) => [PopupMenuItem(child: Text('History'))], ),
        title: TabBar(dividerHeight: 0,
        indicatorColor: Colors.transparent,
        automaticIndicatorColorAdjustment: false,
     
       // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        controller: _tabController,
       
        tabs: [
        Tab(icon: Icon(
          
          Icons.calculate_sharp,),),
        Tab(icon: Icon(Icons.settings)),
      ],),),
      //
    //   AppBar(
    //     backgroundColor: Colors.amber,
    //    elevation: 0.0,
    //  ),
      body:TabBarView(
        controller: _tabController,
        children: _screenWidget
        ,
      ));
  }

 
}
