import 'package:flutter/material.dart';
import 'package:xiecheng/pages/homePage.dart';
import 'package:xiecheng/pages/myPage.dart';
import 'package:xiecheng/pages/searchPage.dart';
import 'package:xiecheng/pages/travelPage.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  // 颜色常量
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  // 当前页面的指示
  int _currentIndex = 0;
  // 页面控制器
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        // 定义首页的四个页面
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        onTap: (index){
          // 跳转至点击index对应的页面
          _pageController.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        // 固定底部四个item不动
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _defaultColor,),
            activeIcon: Icon(Icons.home, color: _activeColor,),
            title: Text('首页', style: TextStyle(
              color: _currentIndex != 0 ? _defaultColor : _activeColor
            ))),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _defaultColor,),
            activeIcon: Icon(Icons.search, color: _activeColor,),
            title: Text('搜索', style: TextStyle(
              color: _currentIndex != 1 ? _defaultColor : _activeColor
            ))),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, color: _defaultColor,),
            activeIcon: Icon(Icons.camera_alt, color: _activeColor,),
            title: Text('旅拍', style: TextStyle(
              color: _currentIndex != 2 ? _defaultColor : _activeColor
            ))),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _defaultColor,),
            activeIcon: Icon(Icons.account_circle, color: _activeColor,),
            title: Text('我的', style: TextStyle(
              color: _currentIndex != 3 ? _defaultColor : _activeColor
            ))),
            
        ],),
    );
  }
}