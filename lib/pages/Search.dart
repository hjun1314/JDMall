import 'package:flutter/material.dart';
import '../config/Config.dart';
import '../tools/ScreenAdaper.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索详情"),
      ),
    );
  }
}