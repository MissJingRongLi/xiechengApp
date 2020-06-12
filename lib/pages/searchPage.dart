import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xiecheng/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
        child: SearchBar(
        enabled: false,
        hideLeft:false,
        hint: '请输入要搜索的内容',
        leftButtonClick: (){
          Navigator.pushReplacementNamed(context, '/home');
        },
      ))
    );
  }
}