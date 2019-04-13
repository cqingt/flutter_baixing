import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_detail.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<GoodsDetailProvide>(context).goodsDetail.data.goodInfo.goodsDetail;

    return Provide<GoodsDetailProvide>(
      builder: (context, child, data) {
        var isLeft = Provide.value<GoodsDetailProvide>(context).isLeft;

        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            margin: EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: Text('暂时没有数据'),
          );
        }
      },
    );
    
     
  }
}