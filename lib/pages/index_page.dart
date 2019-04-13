import 'package:flutter/material.dart'; // ios风格
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // 底部导航
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
//    BottomNavigationBarItem(
//      icon: Icon(CupertinoIcons.car),
//      title: Text('论坛'),
//    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      title: Text('会员中心'),
    )
  ];

  // 页面数组
  //final List<Widget> tabBodies = [
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    ImagePickerWidget()
  ];

  // 当前页面索引
  int currentIndex = 0;
  
  // 当前页面
  var currentPage; 

  @override
  void initState() {
    currentPage = tabBodies[currentIndex]; // 默认页面
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context); //设置 设计稿的尺寸，此处ip6

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 导航栏固定
        currentIndex: currentIndex,
        items: bottomTabs,

        // 点击动态设置索引
        onTap: (index){
          setState(() {
           currentIndex = index;
           currentPage =tabBodies[currentIndex]; 
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    //  body: currentPage,
    );
  }
}