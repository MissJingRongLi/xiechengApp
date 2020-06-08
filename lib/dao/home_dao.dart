import 'package:xiecheng/models/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; //使用as作为包的别名，处理重名的冲突

// 定义url
const HOME_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

// 首页接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    if(response.statusCode == 200) {
      // 修复中文乱码的问题
      Utf8Decoder utf8decoder = Utf8Decoder();
      // 解码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      throw Exception('Failed to load home_page.json');
    }
  }
}