import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jdmarket/config/Config.dart';
import 'package:jdmarket/model/ProduContentModel.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';
import '../tools/EventBus.dart';
import '../tools/CartService.dart';
import '../productContent/productContentCartNum.dart';

class ProductContentFirstPage extends StatefulWidget {
  final List _productContentList;
  ProductContentFirstPage(this._productContentList, {Key key})
      : super(key: key);

  @override
  _ProductContentFirstPageState createState() =>
      _ProductContentFirstPageState();
}

class _ProductContentFirstPageState extends State<ProductContentFirstPage>
    with AutomaticKeepAliveClientMixin {
  ProductContentitem _productContent;

  List _attr = [];

  String _selectedValue;

  bool get wantKeepAlive => true;
  var actionEventBus;

  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContentList[0];

    this._attr = this._productContent.attr;

    _initAttr();
    //监听广播
    this.actionEventBus = eventBus.on<ProductContentEvent>().listen((str) {
      print("监听广播${str}....");
      print(str);
      this._attrBottomSheet();
    });
    //销毁
    @override
    void dispose() {
      super.dispose();
      this.actionEventBus.cancel();
    }
    //[{"cate":"鞋面材料","list":["牛皮 "]},{"cate":"闭合方式","list":["系带"]},{"cate":"颜色","list":["红色","白色","黄色"]}]

    // list":["系带","非系带"]

    /*   
   [
     
      {
       "cate":"尺寸",
       list":[{

            "title":"xl",
            "checked":false
          },
          {

            "title":"xxxl",
            "checked":true
          },
        ]
      },
      {
       "cate":"颜色",
       list":[{

            "title":"黑色",
            "checked":false
          },
          {

            "title":"白色",
            "checked":true
          },
        ]
      }
  ]    
   */
  }

  //初始化Attr 格式化数据
  _initAttr() {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }

    // print(attr[0].attrList);
    // print(attr[0].cate);
    // print(attr[0].list);
    _getSelectedAttrValue();
  }

  //改变属性值
  _changeAttr(cate, title, setBottomState) {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
      this._attr = attr;
    });
    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]["title"]);
        }
      }
    }
    // print(tempArr.join(','));
    setState(() {
      this._selectedValue = tempArr.join(',');
    });
  }

  //循环具体属性
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            _changeAttr(attrItem.cate, item["title"], setBottomState);
          },
          child: Chip(
            label: Text("${item["title"]}"),
            padding: EdgeInsets.all(10),
            backgroundColor: item["checked"] ? Colors.red : Colors.black26,
          ),
        ),
      ));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdaper.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdaper.height(22)),
              child: Text("${attrItem.cate}: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: ScreenAdaper.width(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          )
        ],
      ));
    });

    return attrList;
  }

  //底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (contex) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return GestureDetector(
                //解决showModalBottomSheet点击消失的问题
                onTap: () {
                  return false;
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(ScreenAdaper.width(20)),
                      child: ListView(
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _getAttrWidget(setBottomState)),
                          Divider(),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: ScreenAdaper.height(80),
                            child: InkWell(
                              onTap: () {
                                // _attrBottomSheet();
                              },
                              child: Row(
                                children: [
                                  Text("数量:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 10),
                                  ProductContentCartNumPage(
                                      this._productContent)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      width: ScreenAdaper.width(750),
                      height: ScreenAdaper.height(76),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: JDButtonPage(
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                text: "加入购物车",
                                sb: () {
                                  print('加入购物车');
                                  CartServices.addCart(this._productContent);
                                  Navigator.of(context).pop();
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
                                  text: "立即购买",
                                  sb: () {
                                    print('立即购买');
                                  },
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //处理图片
    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', '/');
    ScreenAdaper.init(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Image.network("${pic}", fit: BoxFit.cover),
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("${this._productContent.title}",
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenAdaper.size(36))),
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text("${this._productContent.subTitle}",
                  style: TextStyle(
                      color: Colors.black54, fontSize: ScreenAdaper.size(28)))),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text("特价: "),
                      Text("¥${this._productContent.price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdaper.size(46))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价: "),
                      Text("¥${this._productContent.oldPrice}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdaper.size(28),
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          this._attr.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: ScreenAdaper.height(80),
                  child: InkWell(
                    onTap: () {
                      _attrBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        Text("已选: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("${this._selectedValue}")
                      ],
                    ),
                  ),
                )
              : Text(""),
          Divider(),
          Container(
            height: ScreenAdaper.height(80),
            child: Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
