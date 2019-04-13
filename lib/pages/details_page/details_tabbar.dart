import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_detail.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, data) {
        var isLeft = Provide.value<GoodsDetailProvide>(context).isLeft;
        var isRight = Provide.value<GoodsDetailProvide>(context).isRight;

        return Container(
          margin: EdgeInsets.only(top: 15),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _myTabbarLeft(context, isLeft),
                  _myTabbarRight(context, isRight),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _myTabbarLeft(BuildContext context,bool isLeft) {
    return InkWell(
      onTap: (){
        Provide.value<GoodsDetailProvide>(context).changeAction('left');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: isLeft ? Colors.pink : Colors.black12
            )
          )
        ),
        child: Text(
          '详细',
          style: TextStyle(color: isLeft?Colors.pink:Colors.black26)
        ),
      ),
    );
  }

  Widget _myTabbarRight(BuildContext context,bool isRight) {
    return InkWell(
      onTap: (){
        Provide.value<GoodsDetailProvide>(context).changeAction('right');
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: isRight ? Colors.pink : Colors.black12
            )
          )
        ),
        child: Text(
          '评论',
          style: TextStyle(color: isRight?Colors.pink:Colors.black26)
        ),
      ),
    );
  }
}


class DetailsBar extends StatefulWidget {
  @override
  _DetailsBarState createState() => _DetailsBarState();
}

class _DetailsBarState extends State<DetailsBar> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs = ['详情', '评论'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener((){
        switch(_tabController.index) {
          case 0:

            break;
          case 1:

            break;
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: _tabController,
        tabs: tabs.map((e) => Tab(text: e,)).toList(),
        indicatorColor: Colors.pink,
        indicatorWeight: 1,
        labelColor: Colors.pink,
        unselectedLabelColor: Colors.black26,
      ),
    );
  }
}