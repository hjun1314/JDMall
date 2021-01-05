import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import '../../widget/JDText.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          FlatButton(
            child: Text("客服"),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Center(
              child: Container(
                  margin: EdgeInsets.only(top: 30),
                  height: ScreenAdaper.height(160),
                  width: ScreenAdaper.width(160),
                  child: Image.network(
                      "https://www.itying.com/images/flutter/list5.jpg",
                      fit: BoxFit.cover)),
            ),
            SizedBox(height: 30),
            JDTextPage(
              text: "请输入用户名",
              onChanged: (value) {},
            ),
            SizedBox(height: 10),
            JDTextPage(
              text: "请输入密码",
              password: true,
              onChanged: (value) {},
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(ScreenAdaper.width(20)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("忘记密码"),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Text("新用户注册"),
                        onTap: () {
                          Navigator.pushNamed(context, '/registerFirst');
                        },
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
