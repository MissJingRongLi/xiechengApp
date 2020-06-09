import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// 设置白名单
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String icon; //icon
  final String title; //标题
  final String url; //链接
  final String statusBarColor; //当前Bar的主题色
  final bool hideAppBar;
  final bool backForbid;//是否禁止返回

  const WebView({Key key, this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar, this.backForbid = false}) : super(key: key); //是否隐藏bar
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = new FlutterWebviewPlugin();
  
  // 返回状态的标志位
  bool exiting = false;
  // 接受相关事件的监听
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  @override
  void initState(){
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url){

    });

   _onStateChanged =  webviewReference.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.startLoad:
        // 禁止返回 跳转到首页
          if(_isToMain(state.url) && !exiting){
            if(widget.backForbid){
              webviewReference.launch(widget.url);
            }else{
            // 否则跳转下一页
            Navigator.pop(context);
            exiting = true;
          }
          }
          break;
        default:
        break;
      }
    });

    _onHttpError = webviewReference.onHttpError.listen((error) {
      print(error);
    });
  }

  // 判断路由域名是否在白名单中
  _isToMain(String url){
    bool isContain = false;
    // url中相关特殊字符的转义处理
    url = Uri.decodeFull(url);
    for(final value in CATCH_URLS){
      // 如果url不为空，则取endWith， 否则直接设为false
      if(url?.endsWith(value) ?? false){
        isContain = true;
        break;
      }
    }
    return isContain;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // 取消相关监听
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
  }
  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;

  if(statusBarColorStr == 'ffffff'){
    backButtonColor = Colors.black;
  }else{
    backButtonColor = Colors.white;
  }

    return Scaffold(
      body: Column(
        children: <Widget>[
          // 将字符串类型的颜色转换为 int类型
          _appBar(Color(int.parse('0xff'+statusBarColorStr)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withLocalStorage: true,
              hidden: true,
              // 初始化的显示等待
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('waiting...'),),
              ),))
        ],
      ),
      );
  }

  _appBar(Color backgroundColor, Color backButtonColor){
    if(widget.hideAppBar ?? false){
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      child: FractionallySizedBox(
        // 撑满宽度
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left:10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left:0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(fontSize: 20, color: backButtonColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}