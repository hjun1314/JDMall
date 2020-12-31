import 'package:flutter/material.dart';
import 'package:jdmarket/cart/CartItem.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
// import 'package:flutter/widgets.dart';
// import '../model/ProduContentModel.dart';
class CartNumPage extends StatefulWidget {
  // ProductContentitem _productContentitem;
  Map _itemData;
  CartNumPage(this._itemData,{Key key}) : super(key: key);
  @override
  _CartNumPageState createState() => _CartNumPageState();
}

class _CartNumPageState extends State<CartNumPage> {
  
  Map _itemData;
    @override
    void initState() { 
      super.initState();
      this._itemData = widget._itemData;
    }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      width: ScreenAdaper.width(165),
      child: Row(
        children: [_leftBtn(), _centerContent(), _rightBtn()],
      ),
    );
  }

  Widget _leftBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        child: Text("-"),
        height: ScreenAdaper.height(45),
        width: ScreenAdaper.width(45),
      ),
      onTap: () {
      },
    );
  }

  Widget _centerContent() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdaper.width(70),
      height: ScreenAdaper.height(45),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: Colors.black12, width: 1),
              right: BorderSide(color: Colors.black12, width: 1))),
      child: Text("${_itemData["count"]}"),
    );
  }

  Widget _rightBtn() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        child: Text("+"),
        height: ScreenAdaper.height(45),
        width: ScreenAdaper.width(45),
      ),
      onTap: () {},
    );
  }
}
