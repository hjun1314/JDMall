import 'package:flutter/material.dart';
import '../productContent/productContentFirst.dart';
import '../productContent/productContentSecond.dart';
import '../productContent/productContentThird.dart';
import '../tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: ScreenAdaper.width(400),
                  child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        child: Text("商品"),
                      ),
                      Tab(
                        child: Text("详情"),
                      ),
                      Tab(
                        child: Text("评价"),
                      ),
                    ],
                  ))
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        ScreenAdaper.width(600), 80, 10, 0),
                    items: [
                      PopupMenuItem(
                        child: Row(
                          children: [Icon(Icons.home), Text("首页")],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [Icon(Icons.search), Text("搜索")],
                        ),
                      )
                    ]);
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                ProductContentFirstPage(),
                ProductContentSecondPage(),
                ProductContentThirdPage()
              ],
            ),
//底部绝对布局
            Positioned(
              width: ScreenAdaper.kScreenWidth(),
              height: ScreenAdaper.height(88),
              bottom: 0,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black26, width: 1)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: ScreenAdaper.height(80),
                        child: Column(
                          children: [Icon(Icons.shopping_cart), 
                          Text("购物车")],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: JDButtonPage(
                          color: Color.fromRGBO(253, 1, 0, 0.9),
                          text: "加入购物车",
                          sb: () {
                            print("加入购物车");
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: JDButtonPage(
                          color: Color.fromRGBO(255, 165, 0, 0.9),
                          text: "立即购买",
                          sb: () {
                            print("立即购买");
                          },
                        ),
                      ),
                    ],
                  )
                  ),
            )
          ],
        ),
      ),
    );
  }
}
