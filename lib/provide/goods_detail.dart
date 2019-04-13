import 'package:flutter/material.dart';
import '../model/detail.dart';
import '../service/service_method.dart';
import 'dart:convert';

class GoodsDetailProvide with ChangeNotifier{
  bool isLeft = true;
  bool isRight = false;

  GoodsDetailModel goodsDetail = null;

  // 切换详情和评论
  changeAction(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }

    notifyListeners();
  }

  getGoodsDetail(String id) async {
    var formData = {'goodId': id};

    await request('getGoodDetailById', formData: formData).then((val){
      var responseData = json.decode(val.toString());

      goodsDetail = GoodsDetailModel.fromJson(responseData);

      notifyListeners();
    });
  }

  
}