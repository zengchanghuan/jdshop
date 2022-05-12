import 'package:flutter/material.dart';
import 'pages/tabs/tabs.dart';
import 'routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute:onGenerateRoute,
    );

  }
}
