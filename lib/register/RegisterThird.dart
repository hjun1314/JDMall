import 'package:flutter/material.dart';
import '../widget/JDText.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';
import 'dart:convert';
import '../tools/Storage.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/Config.dart';
import '../pages/tabs/Tabs.dart';
class RegisterThirdPage extends StatefulWidget {
  Map argumunts;
  RegisterThirdPage({Key key, this.argumunts}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String tel;
  String code;
  String password = '';
  String rpassword = '';
  @override
  void initState() {
    super.initState();
    this.tel = widget.argumunts["tel"];
    this.code = widget.argumunts['code'];
  }

  //注册
  registerAction() async {
    if (password.length < 6) {
      Fluttertoast.showToast(
          msg: "密码长度不能小于6",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else if (rpassword != password) {
      Fluttertoast.showToast(
          msg: "密码和确认密码不一致",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else {
      var api = '${Config.domain}api/register';
      var response = await Dio().post(api, data: {
        "tel": this.tel,
        "code": this.code,
        "password": this.password
      });
      if (response.data["success"]) {
        //保存用户信息
        Storage.setString("userInfo", json.encode(response.data["userinfo"]));
        //回到根目录
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new Tabs()),
            (route) => route == null);
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

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
              onChanged: (value) {
                this.password = value;
              },
            ),
            SizedBox(height: 10),
            JDTextPage(
              text: "请输入确认密码",
              password: true,
              onChanged: (value) {
                this.rpassword = value;
              },
            ),
            SizedBox(height: 20),
            JDButtonPage(
              text: "注册",
              color: Colors.red,
              height: 74,
              sb: registerAction,
            )
          ],
        ),
      ),
    );
  }
}
