import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import '../../cart/CartItem.dart';
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
         Stack(
           children: [
             ListView(
              children: [
                CartItemPage(),
                CartItemPage(),
                CartItemPage(),
                CartItemPage(),
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
                       child:Checkbox(
                         onChanged: (value){

                         },
                         value: true,
                         activeColor: Colors.pink,
                       ) ,
                     ),
                     Text("全选")
                   ],
                 )
               ),
               Align(
                 alignment: Alignment.centerRight,
                 child: RaisedButton(
                   child: Text("结算",style: TextStyle(color: Colors.white)),
                   color: Colors.red,

                   onPressed: (){

                   },
                 ),
               )
             ],
            ),
            
            ),
          )
        ],
      ),
    );
  }
}
