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
  @override
  void initState() {
    super.initState();
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
    var api =
        "${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}";
    print(api);
    var result = await Dio().get(api);
    print(result);
    var productDetailList = new ProductModel.fromJson(result.data);
    if (productDetailList.result.length < this._pageSize) {
      setState(() {
        this._productDetailList.addAll(productDetailList.result);
        this._hasMore = false;
        this.flag = false;
      });
    } else {
      setState(() {
        this._productDetailList.addAll(productDetailList.result);
        this._page++;
        this.flag = true;
      });
    }
  }

  //显示加载中的圈圈
  Widget _showMore(index) {
    if (this._hasMore) {
      return index == this._productDetailList.length - 1
          ? LoadingWidget()
          : Text("");
    } else {
      return index == this._productDetailList.length - 1
          ? LoadingWidget()
          : Text("--我是有底线的--");
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
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text(
                    "销量",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text(
                    "价格",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                  child: Text(
                    "筛选",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () {
                  //侧边栏
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
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
        title: Text("商品详情"),
        //隐藏右侧筛选按钮
        actions: [
          Text(""),
        ],
      ),
      endDrawer: Drawer(
        child: Container(child: Text("实现筛选功能")),
      ),
      body: Stack(
        children: [_productDeatilWidget(), _subHeaderWidget()],
      ),
    );
  }
}
