import 'package:flutter/material.dart';
import 'dart:convert';
import '../tools/Storage.dart';

class CartProvider with ChangeNotifier {
  List _cartList = []; //购物车数据
  bool _isCheckAll = false; //全选
  double _allPrice = 0;
  List get cartList => this._cartList;
  bool get isCheckAll => this._isCheckAll;
  double get allPrice => this._allPrice;

  CartProvider() {
    this.init();
  }
  init() async {
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    //获取全选的状态
    // this._isCheckAll = this.isCheckAll();
    this.computeAllPrice();

    notifyListeners();
  }

  updateCartList() {
    this.init();
  }

  itemCountChange() {
    Storage.setString("cartList", json.encode(this._cartList));
    this.computeAllPrice();

    notifyListeners();
  }

  //全选反选
  checkAll(value) {
    for (var i = 0; i < this._cartList.length; i++) {
      this._cartList[i]["checked"] = value;
    }
    this._isCheckAll = value;
    this.computeAllPrice();
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
  itemChange() {
    if (this.isCheckedAll() == true) {
      this._isCheckAll = true;
    } else {
      this._isCheckAll = false;
    }
    this.computeAllPrice();
    Storage.setString("cartList", json.encode(this._cartList));
    notifyListeners();
  }

//计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]["checked"] == true) {
        tempAllPrice += this._cartList[i]['price'] * this._cartList[i]['count'];
      }
    }
    this._allPrice = tempAllPrice;
    notifyListeners();
  }

//删除数据
  removeItem() {
    //删除数据只是需要把没选中找出来，重新渲染数据界面。如果是直接删除选中的（removeat即是删除下标）会出现显示问题
    List tempList = [];
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]["checked"] == false) {
        tempList.add(this._cartList[i]);
      }
    }
    this._cartList = tempList;
    this.computeAllPrice();
    Storage.setString("cartList", json.encode(this._cartList));
    notifyListeners();
  }
}
