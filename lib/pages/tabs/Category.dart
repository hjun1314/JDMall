import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../tools/ScreenAdaper.dart';
import '../../model/CategoryModel.dart';
import '../../config/Config.dart';
import '../../widget/LoadingWidget.dart';
class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftCateList = new CategoryModel.fromJson(result.data);
    setState(() {
      this._leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[0].sId);
  }

  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=${pid}';
    var result = await Dio().get(api);
    var rightCateList = new CategoryModel.fromJson(result.data);
    setState(() {
      this._rightCateList = rightCateList.result;
    });
  }

//左边数据加载
  Widget _leftCateWidget(leftWidth) {
    if (this._leftCateList.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemCount: this._leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    _selectIndex = index;
                    this._getRightCateData(this._leftCateList[index].sId);
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdaper.height(84),
                    padding: EdgeInsets.only(top: ScreenAdaper.height(24)),
                    child: Text('${this._leftCateList[index].title}',
                        textAlign: TextAlign.center),
                    color: _selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                Divider(height: 1),
              ],
            );
          },
        ),
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

//右边数据加载
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (this._rightCateList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth / rightItemHeight),
            itemCount: this._rightCateList.length,
            itemBuilder: (context, index) {
              //处理图片
              String pic = this._rightCateList[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/productDetail',arguments: {
                    'cid':this._rightCateList[index].sId
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network("${pic}", fit: BoxFit.cover),
                      ),
                      Container(
                          height: ScreenAdaper.height(28),
                          child: Text("${this._rightCateList[index].title}"))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
            child:  LoadingWidget(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    var leftWidth = ScreenAdaper.kScreenWidth() / 4;
    var rightItemWidth =
        (ScreenAdaper.kScreenWidth() - leftWidth - 20 - 20) / 3;
    //获取计算后的宽度
    rightItemWidth = ScreenAdaper.width(rightItemWidth);
    //获取计算后的高度
    var rightItemHeight = rightItemWidth + ScreenAdaper.height(35);
    return Row(
      children: <Widget>[
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }
}
