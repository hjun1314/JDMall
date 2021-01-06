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