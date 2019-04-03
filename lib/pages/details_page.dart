import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/goods_detail.dart';
import './details_page/details_top_area.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _callbackInfo(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton( // 返回按钮
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情'),
        centerTitle: true, // 居中
      ),
      body: FutureBuilder( // 异步的
        future: _callbackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[
                  DetailsTopArea(),
                ],
              )
              
            );
          } else {
            return Text('加载中');
          }
        },
      ),
    );
  }

  Future _callbackInfo(BuildContext context) async {
    await Provide.value<GoodsDetailProvide>(context).getGoodsDetail(goodsId);

    return '加载完成';
  }
}