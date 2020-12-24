import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdaper {
  static init(context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  static height(double value) {
    return ScreenUtil().setHeight(value);
  }
  static size(double value) {
    return ScreenUtil().setSp(value);
  }
  static kScreenHeight() {
    return ScreenUtil().screenHeight;
  }

  static kScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static kStatusBarHeight() {
    return ScreenUtil().statusBarHeight;
  }

  static kBottomBarHeight() {
    return ScreenUtil().bottomBarHeight;
  }
}
