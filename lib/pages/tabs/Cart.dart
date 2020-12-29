import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
// import 'package:provider/provider.dart';
class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
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
      body: Stack(
        children: [
          Text("hahaha"),
          Positioned(
            bottom: 0,
            width: ScreenAdaper.width(750),
            height: ScreenAdaper.height(78),
            child: Container(
            width: ScreenAdaper.width(750),
            height: ScreenAdaper.height(78),
            child: Expanded(
              flex: 1,
              child: Text("123"),
            ),
            
            ),
          )
        ],
      ),
    );
  }
}
