import '../tools/ScreenAdaper.dart';
import 'package:flutter/material.dart';

class JDButtonPage extends StatelessWidget {
  final Color color;
  final String text;
  final Object sb;
  const JDButtonPage(
      {Key key, this.color = Colors.blue, this.text = "nihao", this.sb = null})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return InkWell(
      onTap: this.sb,
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 6, 15, 6),
        padding: EdgeInsets.fromLTRB(15, 6, 15, 6),
        height: ScreenAdaper.height(60),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Center(
          child: Text("${text}", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
