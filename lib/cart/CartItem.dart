import 'package:flutter/material.dart';
import '../tools/ScreenAdaper.dart';
import 'CartNum.dart';
class CartItemPage extends StatefulWidget {
  @override
  _CartItemPageState createState() => _CartItemPageState();
}

class _CartItemPageState extends State<CartItemPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdaper.height(200),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: [
          Container(
            child: Checkbox(
              activeColor: Colors.pink,
              value: true,
              onChanged: (v) {},
            ),
          ),
          Container(
            child: Image.network(
                "https://www.itying.com/images/flutter/list2.jpg"),
            width: ScreenAdaper.width(160),
          ),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "菲特旋转盖轻量杯不锈钢保温杯学生杯商务杯情侣杯保冷杯子便携水杯LHC4131WB(450Ml)白蓝",
                            maxLines: 2),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
child: Text("￥12",style: TextStyle(color: Colors.red),),
                            ),
                           Align(
                             alignment: Alignment.centerRight,
                             child: CartNumPage(),
                           )],
                        )
                      ])))
        ],
      ),
    );
  }
}
