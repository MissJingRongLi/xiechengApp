import 'package:flutter/material.dart';
import 'package:xiecheng/navigator/tab_navigator.dart';
import 'package:xiecheng/pages/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
//        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder> {
          '/home': (BuildContext context) => new TabNavigator(),
        },
      home: TabNavigator(),
    );
  }
}