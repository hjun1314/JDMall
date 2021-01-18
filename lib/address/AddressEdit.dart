import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';
import '../widget/JDText.dart';
import 'package:city_pickers/city_pickers.dart';
import '../tools/EventBus.dart';
import '../config/Config.dart';
import '../tools/SignService.dart';
import '../tools/UserService.dart';
import 'package:dio/dio.dart';

class AddressEditPage extends StatefulWidget {
  Map arguments;
  AddressEditPage({Key key, this.arguments}) : super(key: key);

  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  String area = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  
  @override
  void initState() {
    super.initState();
    nameController.text = widget.arguments['name'];
    phoneController.text = widget.arguments['phone'];
    addressController.text = widget.arguments['address'];
   
  }

//页面销毁刷新
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventBus.fire(new AddressListEvent("刷新成功"));
  }

  @override
  Widget build(BuildContext context) {
     nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length, affinity: TextAffinity.downstream));
  phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length, affinity: TextAffinity.downstream)); 
         addressController.selection = TextSelection.fromPosition(
        TextPosition(offset: addressController.text.length, affinity: TextAffinity.downstream));
    return Scaffold(
      appBar: AppBar(
        title: Text("修改收货地址"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 20),
            JDTextPage(
              text: "收件人姓名",
              controller: nameController,
              onChanged: (value) {
                nameController.text = value;
              },
              
            ),
            SizedBox(height: 10),
            JDTextPage(
              text: "收货人电话",
              controller: phoneController,
            
              onChanged: (value) {
                phoneController.text = value;
              },
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 5),
              height: ScreenAdaper.height(68),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: InkWell(
                child: Row(
                  children: [
                    Icon(Icons.add_location),
                    this.area.length > 0
                        ? Text("${this.area}",
                            style: TextStyle(color: Colors.black54))
                        : Text("省/市/区", style: TextStyle(color: Colors.black54))
                  ],
                ),
                onTap: () async {
                  Result result = await CityPickers.showCityPicker(
                    context: context,
                    cancelWidget:
                        Text("取消", style: TextStyle(color: Colors.red)),
                    confirmWidget:
                        Text("确定", style: TextStyle(color: Colors.blue)),
                  );
                  setState(() {
                    this.area =
                        "${result.provinceName}/${result.cityName}/${result.areaName}";
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            JDTextPage(
              controller: addressController,
              text: "详细地址",
              maxLines: 4,
              height: 200,
              onChanged: (value) {
                addressController.text = value;
              },
            ),
            SizedBox(height: 50),
            JDButtonPage(
                text: "修改",
                color: Colors.red,
                sb: () async {
                  List userinfo = await UserServices.getUserInfo();
                  var tempJson = {
                    "uid": userinfo[0]["_id"],
                    "id": widget.arguments["id"],
                    "name": nameController.text,
                    "phone": phoneController.text,
                    'address': addressController.text,
                    "salt": userinfo[0]['salt']
                  };
                  var sign = SignServices.getSign(tempJson);
                  var api = "${Config.domain}api/editAddress";
                  var result = await Dio().post(api, data: {
                    "uid": userinfo[0]["_id"],
                    "id": widget.arguments["id"],
                    "name": nameController.text,
                    "phone": phoneController.text,
                    'address': addressController.text,
                    "sign": sign
                  });
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
