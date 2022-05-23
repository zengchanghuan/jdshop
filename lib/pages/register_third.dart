import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';
import '../config/Config.dart';
import '../services/Storage.dart';
import '../pages/tabs/Tabs.dart';

class RegisterThirdPage extends StatefulWidget {
  final Map arguments;

  const RegisterThirdPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<RegisterThirdPage> createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  late String tel;
  late String code;
  String password = '';
  String repeatPassword = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tel = widget.arguments['tel'];
    code = widget.arguments['code'];
  }

  //注册
  doRegister() async {
    if (password.length < 6) {
      Fluttertoast.showToast(
        msg: '密码长度不能小于6位',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (repeatPassword != password) {
      Fluttertoast.showToast(
        msg: '密码和确认密码不一致',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var api = '${Config.domain}api/register';
      var response = await Dio()
          .post(api, data: {"tel": tel, "code": code, "password": password});
      if (response.data["success"]) {
        //保存用户信息
        Storage.setString('userInfo', json.encode(response.data["userinfo"]));

        //返回到根
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Tabs()),
        (route) => route == null);
      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("用户注册-第三步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 50),
            JdText(
              text: "请输入密码",
              password: true,
              onChanged: (value) {
                password = value;
                if (kDebugMode) {
                  print(value);
                }
              },
            ),
            const SizedBox(height: 10),
            JdText(
              text: "请输入确认密码",
              password: true,
              onChanged: (value) {
                repeatPassword = value;
                if (kDebugMode) {
                  print(value);
                }
              },
            ),
            const SizedBox(height: 20),
            JdButton(
              text: "登录",
              color: Colors.red,
              height: 74,
              cb: doRegister,
            )
          ],
        ),
      ),
    );
  }
}
