import 'package:flutter/material.dart';
import 'dart:convert';
import '../tools/Storage.dart';
class CartProvider with ChangeNotifier{
   List _cartList=[];  //状态
   bool _isCheckAll = false;
  List get cartList=>this._cartList;
  bool get isCheckAll => this._isCheckAll;
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
  itemCountChange(){
    Storage.setString("cartList", json.encode(this._cartList));
        notifyListeners();

  }
  //全选反选
  checkAll(value){
    for (var i = 0; i < this._cartList.length; i++) {

      this._cartList[i]["checked"] = value;
    }
    this._isCheckAll = value;
    Storage.setString("cartList", json.encode(this._cartList));
    notifyListeners();
    
  }
 //是否全选
 bool isCheckedAll() {
   if (this._cartList.length > 0) {
     for (var i = 0; i < this._cartList.length; i++) {
        if (this._cartList[i]["checked"] == false) {
          return false;
        }
     }
     return true;
   }
   return false;
 }
 //监听每一项的选中事件
 itemChange(){
   if (this.isCheckedAll() == true) {
     this._isCheckAll = true;
   }else{
          this._isCheckAll = false;

   }
   Storage.setString("cartList", json.encode(this._cartList));
   notifyListeners();
 }
  
}