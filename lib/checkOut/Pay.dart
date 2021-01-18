import 'package:flutter/material.dart';
import '../widget/JDButton.dart';

class PayPage extends StatefulWidget {
  PayPage({Key key}) : super(key: key);

  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {
      "title": "支付宝支付",
      "checked": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信支付",
      "checked": false,
      "image": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("结算"),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: this.payList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Image.network("${this.payList[index]["image"]}"),
                      title: Text("${this.payList[index]["title"]}"),
                      trailing: this.payList[index]["checked"]
                          ? Icon(Icons.check)
                          : Text(""),
                      onTap: () {
                        setState(() {
                          for (var i = 0; i < this.payList.length; i++) {
                            this.payList[i]['checked'] = false;
                          }
                          this.payList[index]['checked'] = true;
                        });
                      },
                    ),
                    Divider()
                  ],
                );
              },
            ),
          ),
          JDButtonPage(
            text: "支付",
            color: Colors.red,
            height: 74,
            sb: (){
              print("支付123123213123");
            },
          )
        ],
      ),
    );
  }
}
