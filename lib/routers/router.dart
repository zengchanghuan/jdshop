import 'package:flutter/material.dart';
import '../pages/tabs/tabs.dart';
import '../pages/search.dart';
import '../pages/product_list.dart';
import '../pages/product_content.dart';
import '../pages/tabs/cart.dart';
import '../pages/login.dart';
import '../pages/register_first.dart';
import '../pages/register_second.dart';
import '../pages/register_third.dart';
import '../pages/check_out.dart';
import '../pages/address/address_add.dart';
import '../pages/address/address_edit.dart';
import '../pages/address/address_list.dart';

//配置路由
final Map<String,Function> routes = {
  '/': (context) => const Tabs(),
  '/search': (context) => const SearchPage(),
  '/cart': (context) => const CartPage(),
  '/login': (context) => const LoginPage(),
  '/registerFirst': (context) => const RegisterFirstPage(),
  '/registerSecond': (context,{arguments}) => RegisterSecondPage(arguments:arguments),
  '/registerThird': (context,{arguments}) => RegisterThirdPage(arguments:arguments),
  '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
  '/productContent': (context,{arguments}) => ProductContentPage(arguments:arguments),
  '/checkOut': (context) => const CheckOutPage(),
  '/addressAdd': (context) => const AddressAddPage(),
  '/addressEdit': (context) => const AddressEditPage(),
  '/addressList': (context) => const AddressListPage(),

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
