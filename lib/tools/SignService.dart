import 'package:crypto/crypto.dart';
import 'dart:convert';
class SignServices{
  static getSign(json){
    
    List attrKeys = json.keys.toList();
    attrKeys.sort();//排序 ASCII码
  String str = '';
  for (var i = 0; i < attrKeys.length; i++) {
    str+='${attrKeys[i]}${json[attrKeys[i]]}';
  }
  return  md5.convert(utf8.encode(str)).toString();
  }
}