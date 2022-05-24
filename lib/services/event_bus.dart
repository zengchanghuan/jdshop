import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

//商品详情广播数据
class ProductContentEvent {
  late String str;

  ProductContentEvent(this.str);
}

//用户中心广播
class UserEvent {
  String str;

  UserEvent(this.str);
}
