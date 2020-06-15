 //搜索模型
 class SearchModel {
   String keyword;
   final List<SearchItem> data;

  SearchModel({this.data});

  factory SearchModel.fromJson(Map< String, dynamic> json){
    var dataJson = json['data'] as List;
    List<SearchItem> data = 
      dataJson.map((e) => SearchItem.fromJson(e)).toList();

      return SearchModel(data: data);
  }
 }


class SearchItem {
  // 定义相关参数
  final String word;
  final String type;
  final String price;
  final String star;
  final String zoneName;
  final String districtName;
  final String url;

  SearchItem({this.word, this.type, this.price, this.star, this.zoneName, this.districtName, this.url});

  factory SearchItem.fromJson(Map<String, dynamic> json){
    return SearchItem(
      word: json['word'],
      type: json['type'],
      price: json['price'],
      star: json['star'],
      zoneName: json['zoneName'],
      districtName: json['districtName'],
      url: json['url'],
    );
  }
}