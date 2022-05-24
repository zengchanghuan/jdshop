import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/screen_adapter.dart';
import '../widget/jd_text.dart';
import '../widget/jd_button.dart';
import '../config/config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {

  late String tel;

  sendCode() async {
    if(kDebugMode){
      print(tel);
    }
    RegExp reg = RegExp(r"^1\d{10}$");
    if (reg.hasMatch(tel)) {
      var api = '${Config.domain}api/sendCode';
      var response = await Dio().post(api, data: {"tel": tel});
      if (response.data["success"]) {

        if (kDebugMode) {

          print(response);
        }  //演示期间服务器直接返回  给手机发送的验证码

        Navigator.pushNamed(context, '/registerSecond',arguments: {
          "tel":tel
        });

      } else {
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: '手机号格式不对',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("用户注册-第一步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 50),
            JdText(
              text: "请输入手机号",
              onChanged: (value) {
                tel = value;
              },
            ),
            const SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              cb: () {
                sendCode();
                // Navigator.pushNamed(context, '/registerSecond');
              },
            )
          ],
        ),
      ),
    );
  }
}
