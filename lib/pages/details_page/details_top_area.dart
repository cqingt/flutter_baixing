import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/goods_detail.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, val) {
        var goodsDetail = Provide.value<GoodsDetailProvide>(context).goodsDetail.data.goodInfo;

        if (goodsDetail != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsDetail.image1),
                _goodsName(goodsDetail.goodsName),
                _goodsNum(goodsDetail.goodsSerialNumber)
              ],
            ),
          );
        } else {
          return Text('加载中....');
        }
      },
    );
  }

  Widget _goodsImage(url){
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.only(top:8),
      child: Text("编号：$num", style: TextStyle(color: Colors.black12),),
    );
  }
}