import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  TextEditingController typeController = TextEditingController();
  String textTip = '欢迎来到美好人间高级会所';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text('美好人间'),),
        body: SingleChildScrollView( // 解决键盘遮挡
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: typeController, // 获取input内容
                  // 输入框修饰
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: '美女类型',
                    helperText: '请输入美女类型',
                  ),
                  autofocus: false, // 关闭自动聚焦
                ),

                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text('获取美女类型'),
                ),
                Text(
                  textTip,
                  overflow: TextOverflow.ellipsis, // 超出。。。
                  maxLines: 1, // 最多一行
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

  // 点击请求按钮
  void _choiceAction(){
    print('开始选择你喜欢的类型...........');
    if (typeController.text.toString() == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('美女类型不能为空'),)
      );
    } else {
      httpGet(typeController.text.toString()).then((val){
        // 改变变量值
        setState(() {
          textTip = val['data']['name'].toString();
        });
      });
    }
  }

  Future httpGet(String text) async{

    try {
      Response response;
      var data = {'name': '大姐姐'};
      response = await Dio().get(
          'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
          queryParameters: data
      );

      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
