import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类导航索引，默认是全部
  String categoryId = '4'; //默认的大类ID


  getChildCategory(List<BxMallSubDto> list, id) {
    childIndex = 0; // 切换大类时，索引置0

    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '0';
    all.mallSubId = '0';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];

    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 子类点击更新索引
  changeChildIndex(int index) {
    childIndex = index;
    notifyListeners();
  }
}