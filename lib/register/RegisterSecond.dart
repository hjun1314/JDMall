import 'package:flutter/material.dart';
import '../widget/JDText.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import '../config/Config.dart';
import '../widget/LoadingWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterSecondPage extends StatefulWidget {
  Map arugmunts;
  RegisterSecondPage({Key key, this.arugmunts}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String tel;
  bool sendCodeBtn = false;
  int seconds = 10;
  String code;
  @override
  void initState() {
    super.initState();
    this.tel = widget.arugmunts["tel"];
    this._showTimer();
  }

  //倒计时
  _showTimer() {
    Timer timer;
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this.seconds--;
      });
      if (this.seconds == 0) {
        timer.cancel();
        setState(() {
          this.sendCodeBtn = true;
        });
      }
    });
  }

  //重新发送
  repeatSendSmsCode() async {
    setState(() {
      this.sendCodeBtn = false;
      this.seconds = 10;
      this._showTimer();
    });
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {"tel": this.tel});
    if (response.data["success"]) {
      print(response);
    }
  }

  //下一步
  nextAction() async {
    var api = '${Config.domain}api/validateCode';
    var response =
        await Dio().post(api, data: {"tel": this.tel, "code": this.code});
    if (response.data["success"]) {
      Navigator.pushNamed(context, '/registerThird',
          arguments: {"tel": this.tel, 'code': this.code});
    } else {
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

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
              child: Text("验证码已经发送到了您的${this.tel}手机，请输入${this.tel}手机号收到的验证码"),
            ),
            SizedBox(height: 40),
            Stack(
              children: [
                JDTextPage(
                    text: "请输入验证码",
                    onChanged: (value) {
                      this.code = value;
                    }),
                Positioned(
                  right: 0,
                  top: 0,
                  child: this.sendCodeBtn ? RaisedButton(
                    child: Text("重新发送"),
                    onPressed: repeatSendSmsCode,
                  ) : 
                  RaisedButton(
                    child: Text('${this.seconds}秒后重发'),
                    onPressed: (){},
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            JDButtonPage(
                text: "下一步", color: Colors.red, height: 74, sb: nextAction)
          ],
        ),
      ),
    );
  }
}
