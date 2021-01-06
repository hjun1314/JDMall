import 'package:flutter/material.dart';
import '../widget/JDText.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';
class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册第一步"),
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        children: [
          SizedBox(height: 50),
          JDTextPage(
            text: "请输入手机号",
            onChanged: (value){

            },
          ),
          SizedBox(height: 20),
          JDButtonPage(
            text: "下一步",
            color: Colors.red,
            height: 74,
            sb: (){
              Navigator.pushNamed(context, '/registerSecond');
            },
          )
        ],
      ),
    );
  }
}
