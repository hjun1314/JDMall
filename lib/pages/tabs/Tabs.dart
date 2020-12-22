import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import 'Cart.dart';
import 'Category.dart';
import 'Home.dart';
import 'User.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(initialPage: this._currentIndex);
  }

  List<Widget> _pageList = [HomePage(), CategoryPage(), CartPage(), UserPage()];
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        // title: Text("京东商城"),
        leading: IconButton(
            icon:
                Icon(Icons.center_focus_weak, size: 28, color: Colors.black87),
            onPressed: () {}),
        title: InkWell(
          child: Container(
            height: ScreenAdaper.height(66),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.9),
                borderRadius: BorderRadius.circular(33)),
            padding: EdgeInsets.only(left: 10),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(Icons.search),
              Text("笔记本....",
                  style: TextStyle(fontSize: ScreenAdaper.height(28)))
            ]),
          ),
          onTap: (){

          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.message, size: 28, color: Colors.black87),
              onPressed: () {}),
        ],
      ),
      // body: this._pageList[this._currentIndex],
      body: PageView(
        controller: this._pageController,
        children: this._pageList,
        onPageChanged: (index){
        setState(() {
          this._currentIndex = index;
        });
        },
        //禁止滑动
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
            this._pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        items: [
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("首页"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("分类"),
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("购物车"),
            icon: Icon(Icons.shopping_cart),
          ),
          BottomNavigationBarItem(
            // ignore: deprecated_member_use
            title: Text("我的"),
            icon: Icon(Icons.people),
          ),
        ],
      ),
    );
  }
}
