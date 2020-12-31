import 'package:flutter/material.dart';
import '../tools/ScreenAdaper.dart';
import 'CartNum.dart';
class CartItemPage extends StatefulWidget {
  Map _itemData;
  CartItemPage(this._itemData,{Key key}) : super(key: key);

  @override
  _CartItemPageState createState() => _CartItemPageState();
}

class _CartItemPageState extends State<CartItemPage> {
  Map _itemData;
  @override
  void initState() { 
    super.initState();
    this._itemData = widget._itemData;
  }
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
                "${_itemData["pic"]}"),
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
                            "${_itemData["title"]}",
                            maxLines: 2),
                            Text("123"),
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
child: Text("￥${_itemData['price']}",style: TextStyle(color: Colors.red),),
                            ),
                           Align(
                             alignment: Alignment.centerRight,
                             child: CartNumPage(_itemData),
                           )],
                        )
                      ])))
        ],
      ),
    );
  }
}
