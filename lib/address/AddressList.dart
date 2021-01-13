import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import '../provider/CheckOutProvider.dart';
import '../tools/EventBus.dart';
import '../config/Config.dart';
import '../tools/SignService.dart';
import '../tools/UserService.dart';
import 'package:dio/dio.dart';
class AddressListPage extends StatefulWidget {
  AddressListPage({Key key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  
  List addressList = [];
  //监听增加收货地址的广播
  @override
  void initState() { 
    super.initState();
    this._getAddressList();
    eventBus.on<AddressListEvent>().listen((event) {
          this._getAddressList();

    });
  }

  _getAddressList()async{
List userInfo = await UserServices.getUserInfo();
var tempJson = {"uid":userInfo[0]['_id'],'salt':userInfo[0]["salt"]
  };
  var sign = SignServices.getSign(tempJson);
  var api = '${Config.domain}api/addressList?uid=${userInfo[0]['_id']}&sign=${sign}';
  var response = await Dio().get(api);
  print(response.data["result"]);
  setState(() {
    this.addressList = response.data["result"];
  });
  }
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
            ListView.builder(
itemCount: this.addressList.length,
itemBuilder: (context,index){
  return Column(
    children: [
      SizedBox(height: 20),
      ListTile(
                leading: this.addressList[index]["default_address"] == 1 ? Icon(Icons.check, color: Colors.red):Text(""),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${this.addressList[index]["name"]} ${this.addressList[index]["phone"]}"),
                    SizedBox(height: 10),
                    Text("${this.addressList[index]["address"]}")
                  ],
                ),
                trailing: Icon(Icons.edit, color: Colors.blue)
              ),
              Divider(height: 20),
    ],
  );
},
            ),
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
