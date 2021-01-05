import 'package:flutter/material.dart';
import '../widget/JDText.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';

class RegisterSecondPage extends StatefulWidget {
  RegisterSecondPage({Key key}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册第二步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        child: ListView(
          children: [
            SizedBox(height: 50),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text("请输入xxx手机收到的验证码,请输入xxx手机收到的验证码"),
            ),
            SizedBox(height: 40),
            Stack(
              children: [
                JDTextPage(
                  text: "请输入验证码",
                  onChanged: (value) {},
                ),
                Positioned(
                  right:0,
                  top: 0,
                  child: RaisedButton(
                    child: Text("重新发送"),
                    onPressed: (){

                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            JDButtonPage(
              text: "下一步",
              color:Colors.red,
              height: 74,
              sb: (){
                Navigator.pushNamed(context, '/registerThird');
              },
            )
          ],
        ),
      ),
    );
  }
}
