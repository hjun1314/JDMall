import 'package:flutter/material.dart';
import '../widget/LoadingWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class ProductContentSecondPage extends StatefulWidget {
  final List _productContentList;

  ProductContentSecondPage(this._productContentList, {Key key})
      : super(key: key);

  @override
  _ProductContentSecondPageState createState() =>
      _ProductContentSecondPageState();
}

class _ProductContentSecondPageState extends State<ProductContentSecondPage>
    with AutomaticKeepAliveClientMixin {
  var _id;
  bool get wantKeepAlive => true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    this._id = widget._productContentList[0].sId;
    print(this._id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //默认加载地址
      child: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: "http://jd.itying.com/pcontent?id=${this._id}",
          
        );
      }),
    );
  }
}
