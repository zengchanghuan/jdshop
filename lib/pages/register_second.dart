import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/screen_adapter.dart';
import '../widget/jd_text.dart';
import '../widget/jd_button.dart';
import '../config/config.dart';

class RegisterSecondPage extends StatefulWidget {
  final Map arguments;

  const RegisterSecondPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  late String tel = '';
  bool sendCodeBtn = false;
  int seconds = 10;
  late String code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tel = widget.arguments['tel'];
    _showTimer();
  }

  //倒计时
  _showTimer() {
    Timer t;
    t = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        seconds--;
      });
      if (seconds == 0) {
        timer.cancel(); //清除定时器
        setState(() {
          sendCodeBtn = true;
        });
      }
    });
  }

  //重新发送验证码
  sendCode() async {
    setState(() {
      sendCodeBtn = false;
      seconds = 10;
      _showTimer();
    });
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {"tel": tel});
    if (response.data["success"]) {
      if (kDebugMode) {
        print(response);
      } //演示期间服务器直接返回  给手机发送的验证码
    }
  }

  //验证验证码

  validateCode() async {
    var api = '${Config.domain}api/validateCode';
    var response =
        await Dio().post(api, data: {"tel": tel, "code": code});
    if (response.data["success"]) {
      Navigator.pushNamed(context, '/registerThird',arguments: {
        "tel":tel,
        "code":code
      });

    } else {
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("用户注册-第二步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("验证码已经发送到了您的$tel手机，请输入$tel手机号收到的验证码"),
            ),
            const SizedBox(height: 40),
            Stack(
              children: <Widget>[
                SizedBox(
                  child: JdText(
                    text: "请输入验证码",
                    onChanged: (value) {
                      // print(value);
                      code = value;
                    },
                  ),
                  height: ScreenAdapter.height(100),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: sendCodeBtn
                      ? ElevatedButton(
                    child: const Text('重新发送'),
                    onPressed: sendCode,
                  )
                      : ElevatedButton(
                    child: Text('$seconds秒后重发'),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              cb: validateCode,
            )
          ],
        ),
      ),
    );
  }
}
