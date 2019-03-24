import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            MyNumber(),
            MyButton()
          ],
        ),
      ),
    );
  }
}

class MyNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(top: 200.0),
      child: Provide<Counter>(
        builder: (context, child, counter){
          return Text(
            '${counter.value}',
            style: Theme.of(context).textTheme.display1,
          );
        },
      )
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        Provide.value<Counter>(context).increment();
      },
      child: Text('自增'),
    );
  }
}