import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import '../tools/SignService.dart';
import '../tools/UserService.dart';
import '../model/OrderModel.dart';
import '../config/Config.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List _orderList = [];
  @override
  void initState() {
    super.initState();
    this._getListData();
  }

  _getListData() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]['_id'], 'salt': userinfo[0]['salt']};
    var sign = SignServices.getSign(tempJson);
    var api =
        '${Config.domain}api/orderList?uid=${userinfo[0]['_id']}&sign=${sign}';
    var response = await Dio().get(api);
        print(response.data);
    setState(() {
      var orderModel = new OrderModel.fromJson(response.data);
      this._orderList = orderModel.result;
            print(this._orderList[0].name);
        print("eeeeee");

    });
  }

  //自定义商品列表组件
  List<Widget> _orderItemWidget(orderItems) {
    List<Widget> tempList = [];
    for (var i = 0; i < orderItems.length; i++) {
      tempList.add(Column(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: ScreenAdaper.width(120),
              height: ScreenAdaper.height(120),
              child: Image.network(
                "${orderItems[i].productImg}",
                fit: BoxFit.cover,
              ),
            ),
            title: Text("${orderItems[i].productTitle}"),
            trailing: Text('x${orderItems[i].productCount}'),
          ),
          SizedBox(height: 10)
        ],
      ));
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的订单"),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, ScreenAdaper.height(80), 0, 0),
            padding: EdgeInsets.all(ScreenAdaper.width(15)),
            child: ListView(
                children: this._orderList.map((value) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/orderinfo');
                },
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("订单编号：${2131231}",style: TextStyle(color: Colors.black54))
                      ),
                      Divider(),
                      Column(children: this._orderItemWidget(value.orderItem)),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Text("合计：￥${"1111"}"),
                        trailing: FlatButton(
                          child: Text("申请售后"),
                          onPressed: () {},
                          color: Colors.grey[100],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList()),
          ),
          Positioned(
              top: 0,
              width: ScreenAdaper.width(750),
              height: ScreenAdaper.height(76),
              child: Container(
                width: ScreenAdaper.width(750),
                height: ScreenAdaper.height(76),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Text("全部", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("待付款", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("待收货", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("已完成", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("已取消", textAlign: TextAlign.center),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
