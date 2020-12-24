import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';

class ProductContentFirstPage extends StatefulWidget {
  ProductContentFirstPage({Key key}) : super(key: key);

  @override
  _ProductContentFirstPageState createState() =>
      _ProductContentFirstPageState();
}

class _ProductContentFirstPageState extends State<ProductContentFirstPage> {
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              Container(
                padding: EdgeInsets.all(ScreenAdaper.width(20)),
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            Container(
                                width: ScreenAdaper.width(100),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdaper.width(22)),
                                  child: Text("颜色",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                            Container(
                              width: ScreenAdaper.width(610),
                              child: Wrap(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: [
                            Container(
                                width: ScreenAdaper.width(100),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdaper.width(22)),
                                  child: Text("颜色",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                            Container(
                              width: ScreenAdaper.width(610),
                              child: Wrap(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: [
                            Container(
                                width: ScreenAdaper.width(100),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdaper.width(22)),
                                  child: Text("颜色",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                            Container(
                              width: ScreenAdaper.width(610),
                              child: Wrap(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Chip(
                                      label: Text("白色"),
                                      padding: EdgeInsets.all(10),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          width: ScreenAdaper.width(750),
                          height: ScreenAdaper.height(76),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                 margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                 child: JDButtonPage(
                                   color: Color.fromRGBO(253, 1, 0, 0.9),
                                   text:"加入购物车",
                                   sb: (){
                                     print("加入购物车");
                                   },
                                 ),
                                ),
                                
                              ),
                               Expanded(
                                flex: 1,
                                child: Container(
                                 margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                 child: JDButtonPage(
                                   color: Color.fromRGBO(255, 165, 0, 0.9),
                                   text:"立即购买",
                                   sb: (){
                                     print("立即购买");
                                   },
                                 ),
                                ),
                                
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          AspectRatio(
            child: Image.network("https://www.itying.com/images/flutter/p1.jpg",
                fit: BoxFit.cover),
            aspectRatio: 16 / 9,
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Text("联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑",
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenAdaper.height(36))),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
                "震撼首发，15.9毫米全金属外观，4.9毫米轻薄窄边框，指纹电源按钮，杜比音效，2G独显，预装正版office软件",
                style: TextStyle(
                    color: Colors.black54, fontSize: ScreenAdaper.height(28))),
          ),
          //价格
          Container(
              child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(children: [
                  Text("特价"),
                  Text("￥28",
                      style: TextStyle(
                          color: Colors.red, fontSize: ScreenAdaper.size(36)))
                ]),
              ),
              Expanded(
                flex: 1,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text("原价"),
                  Text("￥44",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: ScreenAdaper.size(28),
                          decoration: TextDecoration.lineThrough))
                ]),
              ),
            ],
          )),
          //筛选
          Container(
              margin: EdgeInsets.only(top: 10),
              height: ScreenAdaper.height(80),
              child: InkWell(
                onTap: () {
                  _attrBottomSheet();
                },
                child: Row(
                  children: [
                    Text("已选", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("115，黑色，XL，1件")
                  ],
                ),
              )),
          Divider(),
          Container(
            // margin: EdgeInsets.only(top: 10),
            height: ScreenAdaper.height(80),
            child: Row(
              children: [
                Text("运费", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
