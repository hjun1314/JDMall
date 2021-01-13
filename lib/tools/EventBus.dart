import 'package:event_bus/event_bus.dart';
EventBus eventBus = EventBus();
//商品详情广播
class ProductContentEvent{
  String str;
  ProductContentEvent(String str){
    this.str = str;
  }
}
//用户中心广播
class UserEvent{
  String str;
  UserEvent(String str){
    this.str = str;
  }

}
//地址列表广播
class AddressListEvent{
  String str;
  AddressListEvent(String str){
    this.str = str;
  }

}
//结算页面
class CheckOutEvent{
  String str;
  CheckOutEvent(String str){
    this.str = str;
  }
}