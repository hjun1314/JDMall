//点击加入购物车
import 'package:flutter/material.dart';
import 'package:jdmarket/tools/ScreenAdaper.dart';
import 'package:flutter/widgets.dart';
import '../model/ProduContentModel.dart';

class ProductContentCartNumPage extends StatefulWidget {
  ProductContentitem _productContent;
  ProductContentCartNumPage(this._productContent, {Key key}) : super(key: key);
  @override
  _ProductContentCartNumPageState createState() =>
      _ProductContentCartNumPageState();
}

class _ProductContentCartNumPageState extends State<ProductContentCartNumPage> {
  ProductContentitem _productContent;
  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContent;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      width: ScreenAdaper.width(165),
      child: Row(
        children:<Widget> [_leftBtn(), _centerContent(), _rightBtn()],
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
        if (this._productContent.count > 1) {
          setState(() {
            this._productContent.count = this._productContent.count - 1;
          });
        }
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
      child: Text("${this._productContent.count}"),
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
      onTap: () {
        setState(() {
          this._productContent.count = this._productContent.count + 1;
        });
      },
    );
  }
}
