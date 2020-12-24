import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../tools/ScreenAdaper.dart';
import 'package:dio/dio.dart';
import '../../model/FocusModel.dart';
import '../../config/Config.dart';
import '../../model/ProductModel.dart';
import '../../widget/LoadingWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  //tabbar保持刷新状态
  bool get wantKeepAlive => true;

  List _focusDataList = [];
  List _hotProductDataList = [];
  List _bestProductDataList = [];
  @override
  void initState() {
    super.initState();
    _getFoucsData();
    _getHotProductData();
    _getBestProductData();
  }

  _getFoucsData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      this._focusDataList = focusList.result;
    });
    print(this._focusDataList);
  }

  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductData = ProductModel.fromJson(result.data);
    setState(() {
      this._hotProductDataList = hotProductData.result;
    });
  }

  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductData = ProductModel.fromJson(result.data);
    setState(() {
      this._bestProductDataList = bestProductData.result;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (this._focusDataList.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              // return new Image.network(
              //   imgList[index]["url"],
              //   fit: BoxFit.fill,
              // );
              String pic = this._focusDataList[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return new Image.network("${pic}", fit: BoxFit.fill);
            },
            itemCount: this._focusDataList.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(40),
      padding: EdgeInsets.only(left: ScreenAdaper.width(10)),
      margin: EdgeInsets.only(left: ScreenAdaper.width(10)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenAdaper.width(10),
      ))),
      child: Text(value, style: TextStyle(color: Colors.black45)),
    );
  }

  //猜你喜欢
  Widget _hotProductWidget() {
    if (this._hotProductDataList.length > 0) {
      return Container(
        height: ScreenAdaper.height(244),
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String sPic = this._hotProductDataList[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: [
                Container(
                  height: ScreenAdaper.height(140),
                  width: ScreenAdaper.width(140),
                  margin: EdgeInsets.only(right: ScreenAdaper.width(20)),
                  child: Image.network("${sPic}", fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                  height: ScreenAdaper.height(44),
                  child: Text("¥${this._hotProductDataList[index].price}"),
                )
              ],
            );
          },
          itemCount: this._hotProductDataList.length,
        ),
      );
    } else {
      return Text("");
    }
  }

  //热门推荐
  _recProductListWidget() {
    var itemWidth = (ScreenAdaper.kScreenWidth() - 30) / 2;

    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this._bestProductDataList.map((value) {
          String sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');
          return InkWell(
            onTap: (){
              print("点击了商品详情跳转");
              Navigator.pushNamed(context, "/productContent",arguments: {"id":value.sId});
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: itemWidth,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(233, 233, 233, 0.9), width: 1),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network("${sPic}", fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                    child: Text("${value.title}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "¥${value.price}",
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "￥${value.oldPrice}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: ScreenAdaper.height(20)),
        _titleWidget("猜你喜欢"),
        SizedBox(height: ScreenAdaper.height(20)),
        _hotProductWidget(),
        _titleWidget("热门推荐"),
        _recProductListWidget(),
      ],
    );
  }
}
