import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xiecheng/models/grid_nav_model.dart';

import '../models/common_model.dart';
import '../models/common_model.dart';
import '../models/common_model.dart';
import '../models/common_model.dart';
import '../models/common_model.dart';
import '../models/grid_nav_model.dart';
import 'webview.dart';

class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;
// 构造函数
  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
//      网格布局数组
      children: _gridNavItems(context)
    )
    );
  }
  _gridNavItems(BuildContext context){
    List<Widget> items = [];
    if(gridNavModel == null){
      return items;
    }
//    酒店
    if(gridNavModel.hotel != null){
      items.add(_gridNavItem(context, gridNavModel.hotel,true));
    }
//    机票
    if(gridNavModel.flight != null){

    }
//  旅行
    if(gridNavModel.travel != null){

    }
  }

//  frist是否为第一个 第一个要与上面保持一定的间距
  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first){
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

    List<Widget> expandWItems = [];
    items.forEach((item){
      expandWItems.add(Expanded(child: item, flex: 1,));
    });

    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    return Container(
      height: 80,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(colors: [startColor, endColor])
      ),
      child: Row(
        children: expandWItems,
      )
    );
  }
//  最左边大的
  _mainItem(BuildContext context, CommonModel model){
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>
                WebView(url: model.url,
                  statusBarColor: model.statusBarColor,
                  title: model.title,
                  hideAppBar: model.hideAppBar,)
            ));
      },
      child: _warpGesture(context, Stack(
        children: <Widget>[
          Image.network(model.icon, fit: BoxFit.contain,
            height: 80, width: 121,
            alignment: AlignmentDirectional.bottomEnd,),
          Text(
            model.title, style: TextStyle(fontSize: 14, color: Colors.white),
          )
        ],
      ), model)
    );
  }

//  两个小的
  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem){
    return Column(
      children: <Widget>[
        Expanded(
          child:  _item(context, topItem, true),
        ),
        Expanded(
          child:  _item(context, bottomItem, false),
        )
      ],
    );
  }

  _item(BuildContext context,CommonModel item, bool first){
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //撑满父元素的宽度
      widthFactor: 1,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                left: borderSide,
                bottom: first ? borderSide : BorderSide.none,
              )
          ),
          child: _warpGesture(context,  Center(
            child: Text(item.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ), item)
      ),
    );
  }

  _warpGesture(BuildContext context, Widget widget, CommonModel model){
    return GestureDetector(
      child: widget,
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>
                WebView(url: model.url,
                  statusBarColor: model.statusBarColor,
                  title: model.title,
                  hideAppBar: model.hideAppBar,)
            ));
      },
    );
  }
}