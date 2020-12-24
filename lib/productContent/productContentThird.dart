import 'package:flutter/material.dart';
class ProductContentThirdPage extends StatefulWidget {
  ProductContentThirdPage({Key key}) : super(key: key);

  @override
  _ProductContentThirdPageState createState() => _ProductContentThirdPageState();
}

class _ProductContentThirdPageState extends State<ProductContentThirdPage> {
  @override
  Widget build(BuildContext context) {
   return  Container(
       child: ListView.builder(
         itemCount: 30,
         itemBuilder: (context,index){
           return ListTile(
             title: Text("第${index}条"),
           );

         },
       )
    );
  }
}