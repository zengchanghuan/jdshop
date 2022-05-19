import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'routers/router.dart';
import 'provider/counter.dart';
import 'package:provider/provider.dart';
import 'provider/cart.dart';

import './pages/tabs/Cart.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1624), //配置设计稿的宽度高度
        builder: () => MultiProvider(
              providers: 
              [
                ChangeNotifierProvider(create: (_) => CountNotifier()),
                ChangeNotifierProvider(create: (_) => Cart()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/',
                onGenerateRoute: onGenerateRoute,
                theme: ThemeData(
                    // primaryColor: Colors.yellow
                    primaryColor: Colors.white),
              ),
            ));
  }
}
