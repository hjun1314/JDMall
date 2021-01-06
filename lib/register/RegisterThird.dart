import 'package:flutter/material.dart';
import '../widget/JDText.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';

class RegisterThirdPage extends StatefulWidget {
  RegisterThirdPage({Key key}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("用户注册第三步")),
      body: Container(
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        child: ListView(
          children: [
            SizedBox(height: 50),
            JDTextPage(
              text: "请输入密码",
              password: true,
              onChanged: (value) {},
            ),
            SizedBox(height: 10),
            JDTextPage(
              text: "请输入确认密码",
              password: true,
              onChanged: (value) {},
            ),
            SizedBox(height: 20),
            JDButtonPage(
              text: "登录",
              color: Colors.red,
              height: 74,
              sb: () {},
            )
          ],
        ),
      ),
    );
  }
}
