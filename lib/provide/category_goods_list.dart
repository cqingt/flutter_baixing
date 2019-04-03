import 'package:flutter/material.dart';

import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier{
  List<CategoryListData> goodsList = [];

  getGoodsList(List<CategoryListData> list) {
    goodsList = list;

    notifyListeners(); // 通知监听者改变数据状态
  }

  addGoodsList(List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners(); // 通知监听者改变数据状态
  }
}