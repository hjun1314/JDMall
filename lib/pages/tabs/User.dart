import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  
  @override
  Widget build(BuildContext context) {

     return Scaffold(
      appBar: AppBar(
        title: Text("用户中心"),
      ),
      body: Center(
        child: Text("用户中心页面"),
      ),
    );
  }
}