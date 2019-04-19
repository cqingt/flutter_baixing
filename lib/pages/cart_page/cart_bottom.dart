import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';


class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context, child, childCategory){
          return Row(
            children: <Widget>[
              _checkbox(context),
              _allPrice(context),
              _buyBtn(context)
            ],
          );
        },
      )
    );
  }

  Widget _checkbox(context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val) {},
          ),

          Text('全选')
        ],
      ),
    );
  }

  Widget _allPrice(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;

    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(280),
                alignment: Alignment.centerRight,
                child: Text('合计：', style: TextStyle(fontSize: ScreenUtil().setSp(32)),),
              ),

              Container(
                width: ScreenUtil().setWidth(150),
                alignment: Alignment.centerLeft,
                child: Text('$allPrice', style: TextStyle(fontSize: ScreenUtil().setSp(36), color: Colors.pink)),
              )
            ]
          ),

          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(22)
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buyBtn(context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(3)
          ),
          child: Text(
            '结算($allGoodsCount)',
            style: TextStyle(
              color: Colors.white
            )
          ),
        ),
      ),
    );
  }
}