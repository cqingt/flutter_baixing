import 'package:flutter/material.dart';
import '../model/detail.dart';
import '../service/service_method.dart';
import 'dart:convert';

class GoodsDetailProvide with ChangeNotifier{
  GoodsDetailModel goodsDetail = null;

  getGoodsDetail(String id) {
    var formData = {'goodId': id};

    request('getGoodDetailById', formData: formData).then((val){
      var responseData = json.decode(val.toString());
      print(responseData);

      goodsDetail = GoodsDetailModel.fromJson(responseData);

      notifyListeners();
    });
  }

  
}