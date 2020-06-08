import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng/dao/home_dao.dart';
import 'package:xiecheng/models/common_model.dart';
import 'package:xiecheng/widgets/local_nav.dart';


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

  // 定义图片数组
  List _imgUrls = [
    'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1466962837,902622328&fm=26&gp=0.jpg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591370192764&di=65403754e5a057a016fad27a06c2a068&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20170917%2Fd9c9faa48234438c9870a68c0cbd4265.jpeg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591370192762&di=70fefbcbc899fbad2e1de5b6d0f3b131&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn20115%2F331%2Fw679h452%2F20190430%2Fe3af-hwfpcxn1463208.jpg'
  ];

  double appBarAlpha = 0;

  // 接口请求返回数据
  List<CommonModel> localNavList = [];

  loadData() {
    HomeDao.fetch().then((value){
      setState(() {
        localNavList = value.localNavList;
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
                  LocalNav(localNavList: localNavList),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text('resultString'),
                    ),
                  )
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
      itemCount: _imgUrls.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          _imgUrls[index],
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
