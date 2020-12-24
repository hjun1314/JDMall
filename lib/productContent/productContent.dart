import 'package:flutter/material.dart';
class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key,this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("商品...."),
     ),
   );
  }
}