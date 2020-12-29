import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Counter.dart';
class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
     var counterProvider = Provider.of<Counter>(context);
    return Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        counterProvider.incCount();
      },
      child: Icon(Icons.add),
      
    ),
    body: Center(
      child: Text("${counterProvider.count}",style: TextStyle(fontSize: 50)),
    ),
    );
}
}