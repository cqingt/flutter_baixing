import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handler.dart';

class Routes {
  static String route = '/'; //定义根目录
  static String detailsPage = '/detail';  // 定义详情页路由

  // 配置路由
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String,List<String>> params) {
        print('ROUTE NOT FOUND');
      }
    ); //路由未找到

    // 将路由与处理函数绑定
    router.define(detailsPage, handler:detailsHandler);
  }
}