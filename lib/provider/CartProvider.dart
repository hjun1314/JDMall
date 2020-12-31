import 'package:flutter/material.dart';
import 'dart:convert';
import '../tools/Storage.dart';
class CartProvider with ChangeNotifier{
   List _cartList=[];  //状态
  // int _cartNum=0;

  // int get cartNum=>this._cartList.length;
  List get cartList=>this._cartList;

  // addData(value){
  //   this._cartList.add(value);
  //   notifyListeners();
  // }

  // deleteData(value){
  //   this._cartList.remove(value);
  //   notifyListeners();
  // }
  CartProvider(){
    this.init();
  }
  init() async {
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    notifyListeners();
  }
  
  updateCartList(){
    this.init();    
  }
  
}