import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xiecheng/models/search_model.dart'; //使用as作为包的别名，处理重名的冲突

// 搜索接口
class SearchDao {
  static Future<SearchModel> fetch(String url, String text) async {
    final response = await http.get(url);
    if(response.statusCode == 200) {
      // 修复中文乱码的问题
      Utf8Decoder utf8decoder = Utf8Decoder();
      // 解码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
       //只有当当前输入的内容和服务器端返回的内容一致时才渲染
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    }else{
      throw Exception('Failed to load Search.json');
    }
  }
}