import 'package:flutter/material.dart'; // android
// import 'package:flutter/cupertino.dart'; ios
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import './routes/application.dart';
import './routes/route.dart';
import './provide/goods_detail.dart';

void main() {
  var count = Counter();
  var providers = Providers();
  var childCategory =ChildCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  var goodsDetailProvide = GoodsDetailProvide();

  providers
    ..provide(Provider<Counter>.value(count))// 添加状态监听
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList))// 添加状态监听
    ..provide(Provider<GoodsDetailProvide>.value(goodsDetailProvide))// 添加状态监听
    ..provide(Provider<ChildCategory>.value(childCategory)); // 添加状态监听

  // ..provide() 添加多个状态管理

  runApp(ProviderNode(child:MyApp(), providers:providers));
  //runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator, // 注入路由
        debugShowCheckedModeBanner: false, // 关闭debug
        theme: ThemeData(
          primaryColor: Colors.pinkAccent
        ),
        home: IndexPage(),
      ),
    );
  }
}