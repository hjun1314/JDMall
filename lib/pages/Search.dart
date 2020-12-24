import 'package:flutter/material.dart';
import '../config/Config.dart';
import '../tools/ScreenAdaper.dart';
import '../tools/SearcServices.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keyWords;
  List _historyListData = [];
  @override
  void initState() {
    super.initState();
    this._getHistoryData();
  }

  _getHistoryData() async {
    var _historyListData = await SearchServices.getHistory();
    setState(() {
      this._historyListData = _historyListData;
    });
    print("-----${_historyListData}-----");
  }

  _showAlertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false, //点击灰色
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息"),
            content: Text("您确定要删除吗？"),
            actions: [
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context, "Cancle");
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  await SearchServices.removeHistoryList(keywords);
                  this._getHistoryData();
                  Navigator.pop(context, "Ok");
                },
              )
            ],
          );
        });
  }

  Widget _historyListWidget() {
    if (_historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "历史记录",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Divider(),
          Column(
            children: this._historyListData.map((value) {
              return Column(children: [
                ListTile(
                  title: Text("${value}"),
                  onLongPress: () {
                    this._showAlertDialog("${value}");
                  },
                ),
                Divider(),
              ]);
            }).toList(),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  width: ScreenAdaper.width(400),
                  height: ScreenAdaper.height(64),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.delete), Text("清空历史记录")],
                  ),
                ),
                onTap: () {
                  SearchServices.clearHistoryListData();
                  this._getHistoryData();
                },
              )
            ],
          )
        ],
      );
    } else {
      return Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              autofocus: false, //是否自动弹出键盘
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(34),
                borderSide: BorderSide.none,
              )),
              onChanged: (value) {
                this._keyWords = value;
              },
            ),
            height: ScreenAdaper.height(68),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
              color: Color.fromRGBO(233, 233, 233, 0.9),
            ),
          ),
          actions: [
            InkWell(
              child: Container(
                  height: ScreenAdaper.height(68),
                  width: ScreenAdaper.width(80),
                  child: Row(
                    children: [Text("搜索")],
                  )),
              onTap: () {
                //点击跳转到搜索详情页面
                SearchServices.setHistoryData(this._keyWords);
                Navigator.pushReplacementNamed(context, "/productDetail",
                    arguments: {"keyWords": this._keyWords});
              },
            )
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                child: Text(
                  "热搜",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Divider(),
              Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("笔记本电脑"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("童装"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("文具"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("笔记本电脑"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              //历史记录
              _historyListWidget()
            ],
          ),
        ));
  }
}
