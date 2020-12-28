import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jdmarket/config/Config.dart';
import 'package:jdmarket/model/ProduContentModel.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';

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
  bool get wantKeepAlive => true;

  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              child:
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(ScreenAdaper.width(20)),
                    child: ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _getAttrWidget(setBottomState),
                        )
                      ],
                    ),
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
                              text: "加入购物车",
                              sb: () {
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
                              text: "立即购买",
                              sb: () {
                                print("立即购买");
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  //初始化筛选选中
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
    _getSelectAttrValue();
  }

  _getSelectAttrValue() {
    var _list = this._attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]["title"]);
        }
      }
    }
    setState(() {
      this._selectedValue = tempArr.join(",");
    });
  }

  //改变属性值
  _chanegAttr(cate, title, setBottomState) {
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
      this._attr = attr;
    });
    _getSelectAttrValue();
  }

  // 商品筛选数据加载
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.list.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: InkWell(
          child: Chip(
            label: Text("${item}"),
            padding: EdgeInsets.all(10),
            backgroundColor: item["checked"] ? Colors.red : Colors.black26,
          ),
          onTap: () {
            _chanegAttr(attrItem.cate, item["title"], setBottomState);
          },
        ),
      ));
    });
    return attrItemList;
  }

  //封装组件渲染
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: [
          Container(
            width: ScreenAdaper.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdaper.height(22)),
              child: Text("${attrItem.cate}:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
              width: ScreenAdaper.width(590),
              child:
                  Wrap(children: _getAttrItemWidget(attrItem, setBottomState)))
        ],
      ));
    });
    return attrList;
  }

  ProductContentitem _productContentitem;
  List _attr = [];
  String _selectedValue;

  @override
  void initState() {
    super.initState();
    this._productContentitem = widget._productContentList[0];
    this._attr = this._productContentitem.attr;
    _initAttr();
    print(this._attr);
  }

  @override
  Widget build(BuildContext context) {
    //处理图片
    String pic = Config.domain + this._productContentitem.pic;
    pic = pic.replaceAll('\\', '/');
    ScreenAdaper.init(context);
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          AspectRatio(
            child: Image.network("${pic}", fit: BoxFit.cover),
            aspectRatio: 4 / 3,
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Text("${this._productContentitem.title}",
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenAdaper.height(36))),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("${this._productContentitem.subTitle}",
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
                  Text("特价 "),
                  Text("￥${this._productContentitem.price}",
                      style: TextStyle(
                          color: Colors.red, fontSize: ScreenAdaper.size(36)))
                ]),
              ),
              Expanded(
                flex: 1,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text("原价 "),
                  Text("￥${this._productContentitem.oldPrice}",
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: ScreenAdaper.size(28),
                          decoration: TextDecoration.lineThrough))
                ]),
              ),
            ],
          )),
          //筛选
      this._attr.length > 0  ?  Container(
              margin: EdgeInsets.only(top: 10),
              height: ScreenAdaper.height(80),
              child: InkWell(
                onTap: () {
                  _attrBottomSheet();
                },
                child: Row(
                  children: [
                    Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("${this._selectedValue}")
                  ],
                ),
              )
              ):Text(""),
          Divider(),
          Container(
            // margin: EdgeInsets.only(top: 10),
            height: ScreenAdaper.height(80),
            child: Row(
              children: [
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
