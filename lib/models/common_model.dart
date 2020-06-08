class CommonModel {
  final String icon; //icon
  final String title; //标题
  final String url; //链接
  final String statusBarColor; //当前Bar的主题色
  final bool hideAppBar; //是否隐藏bar

  CommonModel({
    this.icon,
    this.title,
    this.url,
    this.statusBarColor,
    this.hideAppBar,
  });
  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      icon: json['icon'],
      title: json['title'],
      url:json['url'],
      statusBarColor: json['statusBarColor'],
      hideAppBar: json['hideAppBar']
    );
  }
}