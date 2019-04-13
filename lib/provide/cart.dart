import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';


// 购物车使用模型的好处：字符串转为对象，便于操作，减少错误出现
class CartProvide with ChangeNotifier{
  String cartString = '[]';
  List<CartInfoModel> cartList = []; // 购物车列表 

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');

    var temp  = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int iVal = 0; // 遍历索引

    tempList.forEach((temp) {
      if (temp['goodsId'] == goodsId) {
        tempList[iVal]['count'] = temp['count'] + 1; // 同一个商品多个
        cartList[iVal].count++;
        isHave = true;
      }

      iVal++;
    });

    if (! isHave) {
      Map<String,dynamic> goods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };

      tempList.add(goods);
      cartList.add(CartInfoModel.fromJson(goods)); // 将map 转为对象
    }

    cartString = json.encode(tempList).toString(); // 存储string
    prefs.setString('cartInfo', cartString);
    print('cartString>>>>>>>>>>>${cartString}');
    print('cartList>>>>>>>>>>>>>${cartList}');
    notifyListeners();
  }

  // 获取购物车内容
  getCartInfo () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    cartString = prefs.getString('cartInfo');
    cartList = [];

    if (cartString == null) {

    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast(); // tostring 代码强壮，避免不是string出错

      tempList.forEach((temp){
        cartList.add(CartInfoModel.fromJson(temp)); // 把数据映射到model，方便 操作
      });
    }

    notifyListeners();
  }

  // 清空购物车
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('cartInfo');
    cartList = [];

    print('清空完成-----------------');
    notifyListeners();
  }
}