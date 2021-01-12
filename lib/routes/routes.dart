
import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/ProductDetail.dart';
import '../pages/Search.dart';
import '../productContent/productContent.dart';
import '../pages/tabs/Cart.dart';
import '../pages/tabs/Login.dart';
import '../register/RegisterFirst.dart';
import '../register/RegisterSecond.dart';
import '../register/RegisterThird.dart';
import '../checkOut/CheckOut.dart';
import '../address/AddressAdd.dart';
import '../address/AddressEdit.dart';
import '../address/AddressList.dart';
final routes = {
  '/':(context) => Tabs(),
  '/productDetail':(context,{arguments})=>ProductDetailPage(arguments: arguments),
  '/search':(context) => SearchPage(),
  '/productContent':(context,{arguments})=>ProductContentPage(arguments:arguments),
  '/cart':(context) => CartPage(),
  '/login':(contex) => LoginPage(),
  '/registerFirst':(context) => RegisterFirstPage(),
  '/registerSecond':(context,{arguments}) => RegisterSecondPage(arugmunts: arguments),
  '/registerThird':(context,{arguments}) => RegisterThirdPage(argumunts: arguments),
  '/checkOut':(context) => CheckOutPage(),
  '/addressAdd':(context) => AddressAddPage(),
  '/addressList':(context) => AddressListPage(),

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