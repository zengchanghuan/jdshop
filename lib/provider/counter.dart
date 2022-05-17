import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Counter with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 1; //状态

  int get count => _count; //获取状态

  increment() {
    //更新状态
    _count++;
    notifyListeners(); //表示更新状态
  }
}
