import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import '../../cart/CartItem.dart';
import 'package:provider/provider.dart';
import '../../provider/CartProvider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("购物车"),
          actions: [
            IconButton(
              icon: Icon(Icons.launch),
              onPressed: null,
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
                                  Text("全选")
                                ],
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              child: Text("结算",
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.red,
                              onPressed: () {},
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
