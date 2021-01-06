import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widget/JDText.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';
import 'package:dio/dio.dart';
import '../config/Config.dart';
import '../widget/LoadingWidget.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String tel = '';
  sendSmsCode() async {
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(tel)) {
      var api = '${Config.domain}api/sendCode';
      var response = await Dio().post(api, data: {"tel": this.tel});
      print(response.data);
      print(2222222);
      if (response.data["success"]) {
        Navigator.pushNamed(context, '/registerSecond',
            arguments: {"tel": this.tel});
      } else {
        Fluttertoast.showToast(
            msg: "${response.data["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      }
    } else {
      Fluttertoast.showToast(
          msg: "手机号码格式不对",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }

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
            onChanged: (value) {
              this.tel = value;
            },
          ),
          SizedBox(height: 20),
          JDButtonPage(
            text: "下一步",
            color: Colors.red,
            height: 74,
            sb: this.sendSmsCode,
          )
        ],
      ),
    );
  }
}
