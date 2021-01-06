import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:jdmarket/tools/EventBus.dart';
import 'package:jdmarket/widget/JDButton.dart';
import '../../tools/ScreenAdaper.dart';
import '../../tools/UserService.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLogin = false;
  List userInfo = [];
  @override
  void initState() {
    super.initState();
    this._getUserinfo();
    eventBus.on<UserEvent>().listen((event) {
      this._getUserinfo();
    });
  }
  //监听登录页面改变事件

  _getUserinfo() async {
    var isLogin = await UserServices.getUserLoginState();
    var userInfo = await UserServices.getUserInfo();
    setState(() {
      this.isLogin = isLogin;
      this.userInfo = userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: ScreenAdaper.height(222),
            width: double.infinity,
            //背景图片
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/user_bg.jpg'),
                    fit: BoxFit.cover)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: ClipOval(
                    child: Image.asset('images/user.png',
                        fit: BoxFit.cover,
                        width: ScreenAdaper.width(120),
                        height: ScreenAdaper.height(100)),
                  ),
                ),
               !this.isLogin ?
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Text("登录/注册",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenAdaper.size(32))),
                    //  Text("普通会员",style:TextStyle(color: Colors.white,fontSize: ScreenAdaper.size(24))),

                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
                  ),
                ) :  
                 Expanded(
                   flex: 1,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("用户名：${this.userInfo[0]['username']}",style:TextStyle(color: Colors.white,fontSize: ScreenAdaper.size(32))),
                       Text("普通会员",style:TextStyle(color: Colors.white,fontSize: ScreenAdaper.size(24))),

                     ],
                   ),
                 )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment, color: Colors.red),
            title: Text("全部订单"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Colors.green),
            title: Text("待付款"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_car_wash, color: Colors.orange),
            title: Text("待收货"),
          ),
          Container(
              width: double.infinity,
              height: 10,
              color: Color.fromRGBO(242, 242, 242, 0.9)),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightGreen),
            title: Text("我的收藏"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people, color: Colors.black54),
            title: Text("在线客服"),
          ),
          Divider(),
          this.isLogin
              ? Container(
                  padding: EdgeInsets.all(20),
                  child: JDButtonPage(
                    color: Colors.red,
                    text: "退出登录",
                    sb: () {
                      UserServices.loginOut();
                      this._getUserinfo();
                    },
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}
