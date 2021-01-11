import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import 'package:jdmarket/tools/UserService.dart';
import '../../cart/CartItem.dart';
import 'package:provider/provider.dart';
import '../../provider/CartProvider.dart';
import '../../tools/CartService.dart';
import '../../provider/CheckOutProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEdit = false;
  var changeCheckOutProvider;
//结算跳转
 doCheckOut() async{
   //获取购物车选中的数据
   List checkOutData = await CartServices.getCheckOutData();
   //保存购物车中选中的数据
   this.changeCheckOutProvider.changeCheckOutListData(checkOutData);
   //购物车中有没选中的数据
   if (checkOutData.length > 0) {
     var loginState = await UserServices.getUserLoginState();
     if (loginState) {
          Navigator.pushNamed(context, '/checkOut');
     }else{
        Fluttertoast.showToast(
          msg: '您还没有登录，请登录以后再去结算',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pushNamed(context, '/login');
     }
   } else {
      Fluttertoast.showToast(
          msg: '购物车中没有选中数据',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
   }
 }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    var cartProvider = Provider.of<CartProvider>(context);
    changeCheckOutProvider = Provider.of<CheckOutProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("购物车"),
          actions: [
            IconButton(
              icon: Icon(Icons.launch),
              onPressed: () {
                setState(() {
                  this._isEdit = !this._isEdit;
                });
              },
            )
          ],
        ),
        body: cartProvider.cartList.length > 0
            ? Stack(
                children: [
                  Stack(
                    children: [
                      ListView(
                        children: [
                          Column(
                              children: cartProvider.cartList.map((value) {
                            return CartItemPage(value);
                          }).toList()),
                          SizedBox(height: ScreenAdaper.height(100))
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdaper.width(750),
                    height: ScreenAdaper.height(78),
                    child: Container(
                      width: ScreenAdaper.width(750),
                      height: ScreenAdaper.height(78),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Container(
                                    width: ScreenAdaper.width(60),
                                    child: Checkbox(
                                      onChanged: (value) {
                                        cartProvider.checkAll(value);
                                      },
                                      value: cartProvider.isCheckAll,
                                      activeColor: Colors.pink,
                                    ),
                                  ),
                                  Text("全选"),
                                  SizedBox(width: 10),
                                  this._isEdit == false
                                      ? Text("总价:")
                                      : Text(""),
                                  SizedBox(width: 5),
                                  this._isEdit == false
                                      ? Text("${cartProvider.allPrice}",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.red))
                                      : Text("")
                                ],
                              )),
                          this._isEdit == false
                              ? Align(
                                  alignment: Alignment.centerRight,
                                  child: RaisedButton(
                                    child: Text("结算",
                                        style: TextStyle(color: Colors.white)),
                                    color: Colors.red,
                                    onPressed: doCheckOut,
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.centerRight,
                                  child: RaisedButton(
                                    child: Text("删除",
                                        style: TextStyle(color: Colors.white)),
                                    color: Colors.red,
                                    onPressed: () {
                                      cartProvider.removeItem();
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: Text("购物车空空的..."),
              ));
  }
}
