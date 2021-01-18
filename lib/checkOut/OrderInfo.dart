import 'package:flutter/material.dart';
class OrderInfoPage extends StatefulWidget {
  OrderInfoPage({Key key}) : super(key: key);

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("订单详情"),
       ),
       body: Center(
         child: Text("订单详情页面"),
       )
    );
  }
}