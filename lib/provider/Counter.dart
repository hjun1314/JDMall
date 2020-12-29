import 'package:flutter/material.dart';
class Counter with ChangeNotifier{
  int _count = 1; //状态
  int get count => _count; //获取状态
  
  incCount(){  //更新状态
   this._count++;
   notifyListeners();
  }
}