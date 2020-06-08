import 'package:flutter/material.dart';
import 'package:xiecheng/models/common_model.dart';
import 'package:xiecheng/widgets/webview.dart';

class LocalNav extends StatelessWidget {

  final List<CommonModel> localNavList;
  // 初始化
  const LocalNav({Key key, this.localNavList}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        )
        ),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: _items(context),
          ),
    );
  }

  // 组件 数组
  _items(BuildContext context){
    if(localNavList == null){
      return null;
    }
    List<Widget> items = [];
    localNavList.forEach((model) => {
      items.add(_item(context, model))
    });
    // 返回按行排列
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items,
    );
  }

  // 小item的组件函数
  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context)=>
          WebView(url: model.url, statusBarColor: model.statusBarColor, hideAppBar: model.hideAppBar,)
        ));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 32,
            height: 32,
            ),
            Text(
              model.title,
              style: TextStyle(fontSize: 12),
            ),

        ],
      ),
    );

  }
}