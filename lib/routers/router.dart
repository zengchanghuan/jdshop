import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/Search.dart';
import '../pages/ProductList.dart';
import '../pages/ProductContent.dart';
import '../pages/tabs/cart.dart';
//配置路由
final Map<String,Function> routes = {
  '/': (context) => const Tabs(),
  '/search': (context) => SearchPage(),
  '/cart': (context) => const CartPage(),
  '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
  '/productContent': (context,{arguments}) => ProductContentPage(arguments:arguments),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = routes[name];
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
