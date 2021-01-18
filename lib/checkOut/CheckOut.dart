import 'package:flutter/material.dart';
import 'package:jdmarket/provider/CartProvider.dart';
import '../tools/ScreenAdaper.dart';
import '../provider/CheckOutProvider.dart';
import 'package:provider/provider.dart';
import '../tools/EventBus.dart';
import '../config/Config.dart';
import '../tools/SignService.dart';
import '../tools/UserService.dart';
import 'package:dio/dio.dart';
import '../tools/CheckOutService.dart';
import 'dart:convert';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List _addressList = [];
  @override
  void initState() {
    super.initState();
    this._getDefaultAddress();
    //监听广播
    eventBus.on<CheckOutEvent>().listen((event) {
      this._getDefaultAddress();
    });
  }

//获取默认地址
  _getDefaultAddress() async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userinfo[0]["_id"], "salt": userinfo[0]['salt']};
    var sign = SignServices.getSign(tempJson);
    var api =
        '${Config.domain}api/oneAddressList?uid=${userinfo[0]["_id"]}&sign=${sign}';
    var response = await Dio().get(api);
    setState(() {
      this._addressList = response.data["result"];
    });
  }

  _checkList(item) {
    return Row(
      children: [
        Container(
          width: ScreenAdaper.width(160),
          child: Image.network("${item['pic']}", fit: BoxFit.cover),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${item['title']}", maxLines: 2),
                Text("${item['selectedAttr']}", maxLines: 2),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("￥${item['price']}",
                          style: TextStyle(color: Colors.red)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("x${item['count']}"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var checkOutProvider = Provider.of<CheckOutProvider>(context);
    var carProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("结算"),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    this._addressList.length > 0
                        ? ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${this._addressList[0]["name"]}  ${this._addressList[0]["phone"]}"),
                                SizedBox(height: 10),
                                Text("${this._addressList[0]["address"]}"),
                              ],
                            ),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.pushNamed(context, '/addressList');
                            },
                          )
                        : ListTile(
                            title: Center(
                              child: Text("请添加收货地址"),
                            ),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.pushNamed(context, '/addressAdd');
                            },
                          ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Column(
                    children: checkOutProvider.checkOutListData.map((value) {
                  return Column(
                    children: [_checkList(value), Divider()],
                  );
                }).toList()),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdaper.width(20)),
                height: ScreenAdaper.height(200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("商品总额：￥100"),
                    Divider(),
                    Text("立减：￥5"),
                    Divider(),
                    Text("免运费")
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdaper.width(750),
            height: ScreenAdaper.height(100),
            child: Container(
              width: ScreenAdaper.width(750),
              height: ScreenAdaper.height(100),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black26))),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("总价：￥133",
                            style: TextStyle(color: Colors.red))),
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          child: Text("立即下单",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.red,
                          onPressed: () async {
                            List userinfo = await UserServices.getUserInfo();
                            //商品总价保留一位小数
                            var allPrice = CheckOutService.getAllPrice(
                                    checkOutProvider.checkOutListData)
                                .toStringAsFixed(1);
                            //获取签名
                            var sign = SignServices.getSign({
                              "uid": userinfo[0]["_id"],
                              "phone": this._addressList[0]["phone"],
                              "address": this._addressList[0]["address"],
                              "name": this._addressList[0]["name"],
                              "all_price": allPrice,
                              "products": json
                                  .encode(checkOutProvider.checkOutListData),
                              "salt": userinfo[0]["salt"] //私钥
                            });
                            var api = '${Config.domain}api/doOrder';
                            var response = await Dio().post(api, data: {
                              "uid": userinfo[0]["_id"],
                              "phone": this._addressList[0]["phone"],
                              "address": this._addressList[0]["address"],
                              "name": this._addressList[0]["name"],
                              "all_price": allPrice,
                              "products": json
                                  .encode(checkOutProvider.checkOutListData),
                              "sign": sign
                            });
                                                       print(response);

                            if (response.data["success"]) {
                              //删除购物车选中的商品数据
                              await CheckOutService.removeUnSelectedCartItem();
                              //调用CartProvider更新购物车数据
                              carProvider.updateCartList();

                              Navigator.pushNamed(context, '/pay');
                            }
                          },
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
