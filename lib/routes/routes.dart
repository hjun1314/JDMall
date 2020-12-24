
import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/ProductDetail.dart';
import '../pages/Search.dart';
import '../productContent/productContent.dart';
final routes = {
  '/':(context) => Tabs(),
  '/productDetail':(context,{arguments})=>ProductDetailPage(arguments: arguments),
  '/search':(context) => SearchPage(),
  '/productContent':(context,{arguments})=>ProductContentPage(arguments:arguments),
  
};

var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};