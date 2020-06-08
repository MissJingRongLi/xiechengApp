class ConfigModel {
  final String searchUrl;
  // 初始化
  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(searchUrl: json['searchUrl']);
  }

  Map<String, dynamic > toJson(){
    return {
      searchUrl: searchUrl
    };
  }
}