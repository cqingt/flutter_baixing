import 'package:flutter/material.dart';

import 'package:provide/provide.dart';

class Counter with ChangeNotifier {
  int value = 0;

  increment() {
    value++;
    notifyListeners(); // 状态更新通知
  }
}