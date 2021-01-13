import 'package:flutter/material.dart';
import '../tools/ScreenAdaper.dart';
import '../provider/CheckOutProvider.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
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
                    ListTile(
                      title: Center(
                        child: Text("请添加收货地址"),
                      ),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.pushNamed(context, '/addressList');
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
                          onPressed: () {},
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
