import 'dart:ffi';

import 'package:flutter/material.dart';
import '../tools/ScreenAdaper.dart';
class JDTextPage extends StatelessWidget {
    final double width;
    final bool password;
    final Object onChanged;
    final String text;
    final int maxLines;
    final double height;
    final TextEditingController controller;
   JDTextPage({Key key,this.width = 60,this.password = false,this.onChanged= null,this.text = "输入内容",this.maxLines =1,this.height = 68,this.controller=null}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: this.controller,
        keyboardType: TextInputType.text,
  
        maxLines: this.maxLines,
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
      height: this.height,
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