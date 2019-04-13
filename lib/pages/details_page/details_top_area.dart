import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/goods_detail.dart';
import 'package:transparent_image/transparent_image.dart';

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
                _goodsNum(goodsDetail.goodsSerialNumber),
                _goodsPrice(goodsDetail.presentPrice, goodsDetail.oriPrice)
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
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: url,
      width: ScreenUtil().setWidth(740),
    );
    // return Image.network(
    //   url,
    //   width: ScreenUtil().setWidth(740),
    // );
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

  Widget _goodsPrice(price, originPrice) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: Text(
              "￥$price",
              style: TextStyle(
                fontSize: 20,
                color: Colors.red
              ),
            ),
          ),

          Text(
            "市场价: $originPrice",
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              decoration: TextDecoration.lineThrough
            ),
          )
        ],
      ),
    );
  }
}