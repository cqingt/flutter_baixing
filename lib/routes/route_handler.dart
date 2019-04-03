import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';

// 路由处理函数，处理传参等
Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params) {
    String goodsId = params['id'].first;

    return DetailsPage(goodsId);
  }
);