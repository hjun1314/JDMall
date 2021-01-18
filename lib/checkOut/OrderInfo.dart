import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';

class OrderInfoPage extends StatefulWidget {
  OrderInfoPage({Key key}) : super(key: key);

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("订单详情"),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.add_location),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("张三 13312341234"),
                          SizedBox(height: 10),
                          Text("广州市天河区珠江新城")
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 18),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: ScreenAdaper.width(120),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg",
                              fit: BoxFit.cover),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.black54)),
                                Text("水龙头 洗衣机",
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.black54)),
                                ListTile(
                                  leading: Text("￥100",
                                      style: TextStyle(color: Colors.red)),
                                  trailing: Text("x2"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: ScreenAdaper.width(120),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg",
                              fit: BoxFit.cover),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.black54)),
                                Text("水龙头 洗衣机",
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.black54)),
                                ListTile(
                                  leading: Text("￥100",
                                      style: TextStyle(color: Colors.red)),
                                  trailing: Text("x2"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          width: ScreenAdaper.width(120),
                          child: Image.network(
                              "https://www.itying.com/images/flutter/list2.jpg",
                              fit: BoxFit.cover),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("四季沐歌 (MICOE) 洗衣机水龙头 洗衣机水嘴 单冷快开铜材质龙头",
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.black54)),
                                Text("水龙头 洗衣机",
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.black54)),
                                ListTile(
                                  leading: Text("￥100",
                                      style: TextStyle(color: Colors.red)),
                                  trailing: Text("x2"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //详情信息
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Text("订单编号:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("124215215xx324")
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Text("下单日期:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("2021-1-1")
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Text("支付方式:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("微信支付")
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Text("配送方式:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("顺丰")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Text("总金额"),
                          Text("￥414元", style: TextStyle(color: Colors.red))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
