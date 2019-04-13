import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> tempList = []; 

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: tempList.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(tempList[index]),
                );
              },
            ),
          ),

          RaisedButton(
            onPressed: (){_add();},
            child: Text('添加'),
          ),

          RaisedButton(
            onPressed: (){_clear();},
            child: Text('清空'),
          )
        ],
      ),
    );
  }

  void _show() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var content = prefs.getStringList('tempList');

    if (content != null) {
      setState(() {
       tempList = content; 
      });
    }
  }

  void _add() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = '好好学习，天天向上';
    tempList.add(temp);
    prefs.setStringList('tempList', tempList);

    _show();
  }

  void _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.clear(); //清空所有

    prefs.remove('tempList');

    setState(() {
     tempList = []; 
    });
  }

}
