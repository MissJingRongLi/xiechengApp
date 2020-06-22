


import 'package:flutter/material.dart';

class SpeakPage extends StatefulWidget {
  @override
  _SpeakPageState createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage> with SingleTickerProviderStateMixin{

  String speakTips = '长按说话';
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(microseconds: 1000));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
                ..addStatusListener((status) {
                  if(status == AnimationStatus.completed ){
                    controller.reverse();
                  }else if(status == AnimationStatus.dismissed){
                    controller.forward();
                  }
                });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.stop();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _bottomItem(){
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (e){
              _speakStart();
            },
            onTapUp: (e){
              _speakStop();
            },
            onTapCancel: (){
              _speakCancel();
            },
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(speakTips,
                    style: TextStyle(color: Colors.blue, fontSize: 12),),
                  ),
                  Stack(
                    children: <Widget>[
                      //避免动画执行过程中导致父布局大小改变
                      Container(
                        height: MIC_SIZE,
                        width: MIC_SIZE,
                      ),
                      Center(
                        child: AnimatedMic(
                          animation: animation,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close, size: 30,color: Colors.grey,),
            ),
          )
        ],
      ),
    );
  }

  //开始讲话
  _speakStart(){

  }
  //停止讲话
  _speakStop(){

  }
  //取消讲话
  _speakCancel(){

  }
}

const double MIC_SIZE = 80;
class AnimatedMic extends AnimatedWidget {
  static final _opacityTween = Tween<double> (begin: 1, end: 0.5);
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);

  AnimatedMic({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(MIC_SIZE),
        ),
        child: Icon(Icons.mic, color: Colors.white,size: 30,),
      ),
    );
  }
}
