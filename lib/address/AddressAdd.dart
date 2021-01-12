import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import '../widget/JDButton.dart';
import '../widget/JDText.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressAddPage extends StatefulWidget {
  AddressAddPage({Key key}) : super(key: key);

  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("增加收货地址"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 20),
            JDTextPage(
              text: "收件人姓名",
            ),
            SizedBox(height: 10),
            JDTextPage(
              text: "收货人电话",
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
              text: "详细地址",
              maxLines: 4,
              height: 200,
            ),
            SizedBox(height: 50),
            JDButtonPage(text: "增加", color: Colors.red)
          ],
        ),
      ),
    );
  }
}
