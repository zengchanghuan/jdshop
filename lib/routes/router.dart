import 'package:flutter/material.dart';
import '../pages/tabs/tabs.dart';
import '../pages/search.dart';
import '../pages/product_list.dart';
import '../pages/product_content.dart';
//配置路由
final routes = {
  '/': (context) => const Tabs(),
  '/search': (context) => const SearchPage(),
  '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
  '/productContent': (context,{arguments}) => ProductContentPage(arguments:arguments),


};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
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
