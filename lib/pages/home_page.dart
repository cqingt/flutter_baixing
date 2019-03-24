import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
//
class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin{
  String homePageContent = '正在获取数据';

  int page = 1;
  final List<Map> hotGoodsList = [];

  // 插件要求定义
  GlobalKey<RefreshFooterState> _footerKey =new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;// 状态保持

  @override
  void initState() {
    //_getHotGoods();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
          // 等待异步请求, 不需要initstate
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString()); // 对结果数据进行json
              List<Map> swiperDataList = (data['data']['slides'] as List).cast(); // 对轮播数据 将map 解析成list
              List<Map> navigatorList = (data['data']['category'] as List).cast(); // 分类导航
              String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
              String avatar = data['data']['shopInfo']['leaderImage']; //店长图片
              String telephone = data['data']['shopInfo']['leaderPhone'];

              List<Map> recommendList = (data['data']['recommend'] as List).cast(); // 分类导航

              String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
              String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
              String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
              List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片 
              List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片 
              List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片 

              return EasyRefresh(
                child: ListView( //EasyRefresh 要求我们必须是一个ListView
                  children: <Widget>[
                    SwiperDiy(swiperDataList: swiperDataList),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(adPicture: adPicture),
                    CallPhone(avatar: avatar, telephone: telephone),
                    Recommend(recommendList: recommendList,),
                    FloorTitle(picture: floor1Title),
                    FloorItem(goodsList: floor1),
                    FloorTitle(picture: floor2Title),
                    FloorItem(goodsList: floor2),
                    FloorTitle(picture: floor3Title),
                    FloorItem(goodsList: floor3),
                    _hotGoods()
                  ],
                ),
                loadMore: () async{
                  print('加载更多');

                  var formData = {'page': page};

                  // 请求接口数据
                  await homePageBelowConten(formData).then((val){
                    var data = json.decode(val.toString());

                    // 将json 解析后的数据转为 map 型list
                    List<Map> newGoodsList = (data['data'] as List).cast();

                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++; 
                    });
                  });

                },
                // 自定义样式
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: '',
                  loadedText: '加载完成',
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载...',
                ),
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          }),
    );
  }

  // 火爆专区标题
  Widget hotTitle = Container(
    margin:EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(8.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5, color: Colors.black12)
      )
    ),
    child: Text('火爆专区'),
  );

  // 火爆商品接口
  void _getHotGoods() {
    var formData = {'page': page};

    // 请求接口数据
    homePageBelowConten(formData).then((val){
      var data = json.decode(val.toString());

      // 将json 解析后的数据转为 map 型list
      List<Map> newGoodsList = (data['data'] as List).cast();

      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++; 
      });
    });
  }

  // 流式布局
  Widget _wrapList(){
    if (hotGoodsList.length == 0) {
      return Text('');
    }

    // 将map型的list，转为widget型 list
    List<Widget> listWidget = hotGoodsList.map((val){
      return InkWell(
        onTap: (){print('点击了火爆商品');},
        child: Container(
          width: ScreenUtil().setWidth(372),
          color: Colors.white, // 背景颜色
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.only(bottom: 3.0),
          child: Column(
            children: <Widget>[
              Image.network(val['image'], width:ScreenUtil().setWidth(375)),
              Text(
                val['name'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis, // 超出省略号
                style: TextStyle(color: Colors.pink,fontSize: ScreenUtil().setSp(26)),
              ),
              Row(
                children: <Widget>[
                  Text("￥${val['mallPrice']}"),
                  Text(
                    "￥${val['price']}",
                    style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
                    
                  )
                ],
              )
            ],
          ),
        ),
      );
    }).toList();
  
    return Wrap(
      spacing: 2, // 每行2个
      children: listWidget,
    );
  }

  // 火爆专区组合
  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList()
        ],
      ),
    );
  }
}



// 轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 适配手机屏幕
    //ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context); //设置 设计稿的尺寸，此处ip6

    print("设备像素密度：${ScreenUtil.pixelRatio}");
    print("设备宽度：${ScreenUtil.screenWidth}");
    print("设备高度：${ScreenUtil.screenHeight}");

    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(), // 是否显示切换点
        autoplay: true,
      ),
    );
  }
}

// 分类组件
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  // 创建单个 分类
  Widget _gridViewItemUi(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('被点击了');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),//阻止gridview回弹,导致触动加载更多
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUi(context, item);
        }).toList(), // 将map 转为widget类型的list
      ),
    );
  }
}

// 广告banner
class AdBanner extends StatelessWidget {
  final String adPicture;

  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(this.adPicture),
    );
  }
}

// 电话模块
class CallPhone extends StatelessWidget {
  final String avatar;
  final String telephone;

  CallPhone({Key key, this.avatar, this.telephone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(this.avatar),
      ),
    );
  }

  void _launchUrl() async {
    String url = 'tel:' + telephone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// 商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  // 标题组件
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 2.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text('商品推荐', style: TextStyle(color: Colors.red),),
    );
  }

  // 创建单个item
  Widget _getItem(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(300),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text('￥${recommendList[index]['price']}',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // 整个
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
          itemCount: recommendList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _getItem(index);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top:10.0),
      child: Column(
          children: <Widget>[
            _titleWidget(),
            _recommendList()
          ],
      ),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {
  final String picture;

  FloorTitle({Key key, this.picture}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      child: Image.network(picture),
    );
  }
}

// 楼层商品
class FloorItem extends StatelessWidget {
  final List goodsList;

  FloorItem({Key key, this.goodsList}):super(key: key);

  // 单个商品
  Widget _goodsItem(Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){print('点击商品');},
        child: Image.network(goods['image']),
      ),
    );
  }

  // 第一行
  Widget _firstRow(){
    return Row(
      children: <Widget>[
        _goodsItem(goodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(goodsList[1]),
            _goodsItem(goodsList[2]),
          ],
        )
      ],
    );
  }

  // 最后一行
  Widget _lastRow() {
    return Row(
      children: <Widget>[
        _goodsItem(goodsList[3]),
        _goodsItem(goodsList[4]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _lastRow(),
        ],
      ),
    );
  }
}

// 火爆专区
class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() { 
     super.initState();
      homePageBelowConten({'page': 1}).then((val){
         print(val);
      });
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('1111'),
    );
  }
}