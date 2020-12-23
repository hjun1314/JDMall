import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/LoadingWidget.dart';
import '../model/ProductModel.dart';
import '../config/Config.dart';

class ProductDetailPage extends StatefulWidget {
  Map arguments;
  ProductDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //上拉加载更多
  ScrollController _scrollController = ScrollController();
  //数据
  List _productDetailList = [];
  //分页
  int _page = 1;
  //每页多少数据
  int _pageSize = 8;
  /*
  排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  */
  String _sort = "";
  //解决重复请求问题
  bool flag = true;
  //是否有数据
  bool _hasMore = true;
  //是否有搜索的数据
  bool _hasSearchData = true;
  //二级导航数据
  List _subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  //二级导航栏显示判断
  int _selectHeadId = 1;
  //cid 和 搜索keyWords
  var _cid;
  var _keyWords;
  //配置search搜索框的值
  var _initKeyWordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this._cid = widget.arguments["cid"];
    this._keyWords = widget.arguments["keyWords"];
    //search框赋值
    this._initKeyWordController.text = this._keyWords;
    _getProductDetailData();
    //监听滚动事件
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (this.flag && this._hasMore) {
          _getProductDetailData();
        }
      }
    });
  }

  //加载数据
  _getProductDetailData() async {
    setState(() {
      this.flag = false;
    });
    var api;
    if (this._keyWords == null) {
      api =
          "${Config.domain}api/plist?cid=${this._cid}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}";
    } else {
      api =
          "${Config.domain}api/plist?search=${this._keyWords}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}";
    }

    // print(api);
    var result = await Dio().get(api);
    // print(result);
    var productDetailList = new ProductModel.fromJson(result.data);
    //判断分页。是否最后一页有没有数据
    if (productDetailList.result.length < this._pageSize) {
      setState(() {
        this._productDetailList.addAll(productDetailList.result);
        this._hasMore = false;
        this.flag = true;
      });
    } else {
      setState(() {
        this._productDetailList.addAll(productDetailList.result);
        this._page++;
        this.flag = true;
      });
    }
    //判断是否有搜索数据
    if (productDetailList.result.length == 0 && this._page == 1) {
      setState(() {
        this._hasSearchData = false;
      });
    } else {
      this._hasSearchData = true;
    }
  }

  //显示加载中的圈圈
  Widget _showMore(index) {
    if (this._hasMore) {
      return (index == this._productDetailList.length - 1)
          ? LoadingWidget()
          : Text("");
    } else {
      return (index == this._productDetailList.length - 1)
          ? Text("--我是有底线的--")
          : Text("");
    }
  }

  //导航改变的时候触发
  _subHeaderDataChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState.openEndDrawer();
      setState(() {
        this._selectHeadId = id;
      });
    } else {
      setState(() {
        this._selectHeadId = id;
        this._sort =
            "${this._subHeaderList[id - 1]["fileds"]}_${this._subHeaderList[id - 1]["sort"]}";

        //重置分页
        this._page = 1;
        //重置数据
        this._productDetailList = [];
        //改变sort排序
        this._subHeaderList[id - 1]['sort'] =
            this._subHeaderList[id - 1]['sort'] * -1;
        //回到顶部
        _scrollController.jumpTo(0);
        //重置_hasMore
        this._hasMore = true;
        //重新请求
        this._getProductDetailData();
      });
    }
  }

  //显示header icon
  _showIcon(id) {
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]["sort"] == 1) {
        return Icon(Icons.arrow_drop_down);
      } else {
        return Icon(Icons.arrow_drop_up);
      }
    } else {
      return Text("");
    }
  }

  //商品列表
  Widget _productDeatilWidget() {
    if (this._productDetailList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            String pic = this._productDetailList[index].pic;
            pic = Config.domain + pic.replaceAll("\\", "/");
            return Column(
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: ScreenAdaper.width(180),
                      height: ScreenAdaper.height(180),
                      child: Image.network("${pic}", fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenAdaper.height(180),
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${this._productDetailList[index].title}",
                                overflow: TextOverflow.ellipsis, maxLines: 2),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.9)),
                                  child: Text("4g"),
                                ),
                                Container(
                                  height: ScreenAdaper.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.9)),
                                  child: Text("111"),
                                )
                              ],
                            ),
                            Text("￥${this._productDetailList[index].price}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 20),
                _showMore(index)
              ],
            );
          },
          itemCount: this._productDetailList.length,
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  //顶部刷选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdaper.height(80),
      width: ScreenAdaper.width(750),
      child: Container(
        width: ScreenAdaper.width(750),
        height: ScreenAdaper.height(80),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        child: Row(
          children: this._subHeaderList.map((value) {
            return Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${value["title"]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (this._selectHeadId == value["id"])
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        _showIcon(value["id"]),
                      ],
                    )),
                onTap: () {
                  _subHeaderDataChange(value["id"]);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Container(
            child: TextField(
              controller: this._initKeyWordController,
              autofocus: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(34),
                    borderSide: BorderSide.none),
              ),
              onChanged: (value) {
                setState(() {
                  this._keyWords = value;
                });
              },
            ),
            height: ScreenAdaper.height(68),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.9),
                borderRadius: BorderRadius.circular(34)),
          ),
          //右侧筛选按钮
          actions: [
            InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [Text("搜索")],
                ),
                height: ScreenAdaper.height(68),
                width: ScreenAdaper.width(80),
              ),
              onTap: () {
                this._subHeaderDataChange(1);
              },
            )
          ],
        ),
        endDrawer: Drawer(
          child: Container(child: Text("实现筛选功能")),
        ),
        //是否有搜索数据

        body: _hasSearchData
            ? Stack(
                children: [_productDeatilWidget(), _subHeaderWidget()],
              )
            : Center(
                child: Text("没有您要浏览的数据"),
              ));
  }
}
