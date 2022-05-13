import 'package:flutter/material.dart';
import 'pages/tabs/tabs.dart';
import 'routes/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // Widget build(BuildContext context) {
  //   return ScreenUtilInit(
  //       designSize: Size(750, 1334), //配置设计稿的宽度高度
  //       builder: () => MaterialApp(
  //             debugShowCheckedModeBanner: false,
  //             initialRoute: '/',
  //             onGenerateRoute: onGenerateRoute,
  //             theme: ThemeData(
  //                 // primaryColor: Colors.yellow
  //                 primaryColor: Colors.white),
  //           ));
  // }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
        // primaryColor: Colors.yellow
        primaryColor: Colors.white
        ),
    );

  }

}
