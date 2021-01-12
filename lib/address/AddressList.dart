import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址列表"),
      ),
      body: Container(
        child: Stack(
          children: [
            ListView(children: [
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.check, color: Colors.red),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("张三 13312341234"),
                    SizedBox(height: 10),
                    Text("广州市天河区珠江新城")
                  ],
                ),
                trailing: Icon(Icons.edit, color: Colors.blue),
              ),
              Divider(height: 20),
              ListTile(
                leading: Icon(Icons.check, color: Colors.red),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("张三 13312341234"),
                    SizedBox(height: 10),
                    Text("广州市天河区珠江新城")
                  ],
                ),
                trailing: Icon(Icons.edit, color: Colors.blue),
              ),
              Divider(height: 20),
              ListTile(
                leading: Icon(Icons.check, color: Colors.red),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("张三 13312341234"),
                    SizedBox(height: 10),
                    Text("广州市天河区珠江新城")
                  ],
                ),
                trailing: Icon(Icons.edit, color: Colors.blue),
              ),
              Divider(height: 20),
              ListTile(
                leading: Icon(Icons.check, color: Colors.red),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("张三 13312341234"),
                    SizedBox(height: 10),
                    Text("广州市天河区珠江新城")
                  ],
                ),
                trailing: Icon(Icons.edit, color: Colors.blue),
              ),
              Divider(height: 20),
              ListTile(
                leading: Icon(Icons.check, color: Colors.red),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("张三 13312341234"),
                    SizedBox(height: 10),
                    Text("广州市天河区珠江新城")
                  ],
                ),
                trailing: Icon(Icons.edit, color: Colors.blue),
              ),
              Divider(height: 20),
            ]),
            Positioned(
              bottom: 0,
              width: ScreenAdaper.width(750),
              height: ScreenAdaper.height(88),
              child: Container(
                padding: EdgeInsets.all(5),
                width: ScreenAdaper.width(750),
                height: ScreenAdaper.height(88),
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      Text("增加收货地址", style: TextStyle(color: Colors.white))
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/addressAdd");
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
