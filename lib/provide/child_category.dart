import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类导航索引，默认是全部
  String categoryId = '4'; //默认的大类ID
  String subId = ''; //子类ID
  int page = 1;// 列表页数
  String noMoreText = ''; //分页加载没有更多数据

  // 切换大类
  getChildCategory(List<BxMallSubDto> list, id) {
    childIndex = 0; // 切换大类时，索引置0
    page = 1;
    noMoreText = '';
    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '0';
    all.mallSubId = '';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];

    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 子类点击更新索引
  changeChildIndex(int index, String subId) {
    childIndex = index;
    subId = subId;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  addPage() {
    page++;
  }

  changeNoMoreText(String noMoreText) {
    noMoreText = noMoreText;

    notifyListeners(); // 通知显示
  }
}