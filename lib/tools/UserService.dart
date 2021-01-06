import 'dart:io';

import '../tools/Storage.dart';
import 'dart:convert';
class UserServices {
  static getUserInfo() async{
    List userinfo;
    try {
      List userInfoData = json.decode(await Storage.getString("userInfo"));
      userinfo = userInfoData;
    } catch (e) {
      userinfo = [];
    }
    return userinfo;
  }

  static getUserLoginState() async{
    var userinfo = await UserServices.getUserInfo();
    if (userinfo.length > 0 && userinfo[0]["username"] !="" ) {
      return true;
    }
    return false;
  }

  static loginOut(){
    Storage.remove('userInfo');
  }
  
}

