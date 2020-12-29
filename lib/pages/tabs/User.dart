import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Counter.dart';
class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  
  @override
  Widget build(BuildContext context) {
        var counterProvider=Provider.of<Counter>(context);   

    return Center(      
      child: Text("${counterProvider.count}",style: TextStyle(fontSize: 50)),
);
  }
}