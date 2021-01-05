import 'dart:ffi';

import 'package:flutter/material.dart';
import '../tools/ScreenAdaper.dart';
class JDTextPage extends StatelessWidget {
    final double width;
    final bool password;
    final Object onChanged;
    final String text;
   JDTextPage({Key key,this.width = 60,this.password = false,this.onChanged= null,this.text = "输入内容"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: this.onChanged,
        obscureText: this.password,
        decoration: InputDecoration (
          hintText: this.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none
            
          )
        ),
        
        
      ),
      height: ScreenAdaper.height(68),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
          )
        )
      ),
    );
  }
}