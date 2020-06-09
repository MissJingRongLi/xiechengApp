import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng/dao/home_dao.dart';
import 'package:xiecheng/models/common_model.dart';
import 'package:xiecheng/models/grid_nav_model.dart';
import 'package:xiecheng/models/sales_box_model.dart';
import 'package:xiecheng/widgets/grid_nav.dart';
import 'package:xiecheng/widgets/local_nav.dart';
import 'package:xiecheng/widgets/sale_box.dart';
import 'package:xiecheng/widgets/sub_nav.dart';


// 设置常量 计算何时appbar显示透明
const AppBar_SCROLL_OFFSET = 100;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  double appBarAlpha = 0;

  // 接口请求返回数据
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBox;

  loadData() {
    HomeDao.fetch().then((value){
      setState(() {
        localNavList = value.localNavList;
        gridNavModel = value.gridNav;
        bannerList = value.bannerList;
        subNavList = value.subNavList;
        salesBox = value.salesBox;
        // gridNavList = value.gridNav as List<CommonModel>;
      });
    }).catchError((e){
      print(e);
    });
  }

  void _onScroll(offset){
    // 设置透明度值
    double alpha = offset / AppBar_SCROLL_OFFSET;
    if(alpha < 0){
      alpha = 0;
    }else if(alpha > 1){
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha; 
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 设置背景色
      backgroundColor: Color(0xfff2f2f2),
        body: Stack(
      children: <Widget>[
        // 去除顶部的padding
        MediaQuery.removePadding(
            // 添加顶部参数为true
            removeTop: true,
            context: context,
            // 监听滚动事件
            child: NotificationListener(
              // ignore: missing_return
              onNotification: (ScrollNotification) {
                // 提高性能  --- 滚动 且是列表滚动时
                if (ScrollNotification is ScrollUpdateNotification &&
                // 只需监听最外层的listView
                    ScrollNotification.depth == 0) {
                      _onScroll(ScrollNotification.metrics.pixels);
                    }
              },
              // listView可滚动
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: bannerWidget(),
                  ),
                 Padding(
                   padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                   child:  LocalNav(localNavList: localNavList),
                 ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: GridNav(gridNavModel: gridNavModel,),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: SubNav(subNavList: subNavList,),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
                    child: SaleBox(salesBox: salesBox,),
                  ),
                  Container(
                    height: 800,
                    child: Text('111'),
                    ),
                ],
              ),
            )),
            // 自定义的appBar
        appBarDiy(appBarAlpha),
      ],
    ));
  }

  // 轮播组件
  Widget bannerWidget() {
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          // Image.network（）无法处理HTTP重定向。
          bannerList[index].icon,
          fit: BoxFit.fill,
        );
      },
      pagination: SwiperPagination(),
    );
  }

  // 自定义appBar
  Widget appBarDiy(double appBarAlpha){
    return Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('首页'),
              ),
            ),
          ),
        );
  }
}

