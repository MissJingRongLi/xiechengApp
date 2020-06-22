import 'dart:async';

import 'package:flutter/services.dart';
class AsrManager {
  //MethodChannel flutter与native通信的通道
  static const MethodChannel _channel = const MethodChannel('flutter_asr_plugin');
  /// 定义一些与native通信的接口
  /// 开始录音
  static Future<String> start({Map params}) async {
    return await _channel.invokeMethod('start', params ?? {});
  }
  /// 停止录音
  static Future<String> stop() async {
    return await _channel.invokeMethod('stop');
  }
  /// 取消录音
  static Future<String> cancel() async {
    return await _channel.invokeMethod('cancel');
  }
}