import 'package:flutter/material.dart';
import '../config/Config.dart';
import '../tools/ScreenAdaper.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            autofocus: false,//是否自动弹出键盘
            decoration: InputDecoration(
                border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(34),
              borderSide: BorderSide.none,
            )),
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
            onTap: () {},
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              child: Text("热搜")
            ),
            Divider(),
            Wrap(
              children: [
                Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("笔记本电脑"),
                ),
                Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("童装"),
                ),
                 Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("女装"),
                ),
                 Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("文具"),
                ),
                 Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("笔记本电脑"),
                ),
              ],
            ),
           SizedBox(height: 10),
            Container(
              child: Text("历史记录",style: Theme.of(context).textTheme.title,),
            ),
            Divider(),
            Column(
              children: [
               ListTile(
                 title: Text("笔记本电脑"),
               ),
               Divider(),
               ListTile(
                 title: Text("笔记本电脑"),
               ),
               Divider(),
               ListTile(
                 title: Text("笔记本电脑"),
               ),
               Divider(),
               ListTile(
                 title: Text("笔记本电脑"),
               ),
               Divider(),
               ListTile(
                 title: Text("笔记本电脑"),
               ),
               Divider(),
               ListTile(
                 title: Text("笔记本电脑"),
               ),
               Divider(),

              ],
              
            ),
            SizedBox(height: 100),
            InkWell(
              child: Container(
                width: ScreenAdaper.width(400),
                height: ScreenAdaper.height(64),
                decoration: BoxDecoration(
                 border: Border.all(color: Colors.black45,width: 1), 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete),Text("清空历史记录")
                  ],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}
