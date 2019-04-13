import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/goods_detail.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_web.dart';
import './details_page/details_bottom.dart';

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

            return Stack(
              children: <Widget>[

                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                      // DetailsBar(),
                      DetailsWeb(),
                    ],
                  )
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: Text('加载中'),
            );
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