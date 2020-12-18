import 'package:flutter/material.dart';
class ProductDetailPage extends StatefulWidget {
  Map arguments;
  ProductDetailPage({Key key,this.arguments}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("跳转到商品详情列表"),
      )
      
    );
  }
}