import 'package:flutter/material.dart';
class AddressEditPage extends StatefulWidget {
  AddressEditPage({Key key}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改收货地址"),
      ),
      body: Text("修改收货地址")
    );
  }
}