import 'package:xiecheng/models/common_model.dart';
import 'package:xiecheng/models/config_model.dart';
import 'package:xiecheng/models/grid_nav_model.dart';
import 'package:xiecheng/models/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel({
    this.config, this.bannerList, this.localNavList, this.subNavList, this.gridNav, this.salesBox
  });

  // HomeModel的工厂函数
  factory HomeModel.fromJson(Map<String, dynamic> json){
    var _localNavListJson = json['localNavList'] as List;
    List<CommonModel> _localNavList = _localNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    var _bannerListJson = json['localNavList'] as List;
    List<CommonModel> _bannerList = _bannerListJson.map((e) => CommonModel.fromJson(e)).toList();

    var _subNavListJson = json['localNavList'] as List;
    List<CommonModel> _subNavList = _subNavListJson.map((e) => CommonModel.fromJson(e)).toList();

    return HomeModel(
      localNavList: _localNavList,
      bannerList: _bannerList,
      subNavList: _subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox'])
    );
  }

}