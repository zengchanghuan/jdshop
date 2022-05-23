import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdButton.dart';
import '../widget/JdText.dart';
class RegisterThirdPage extends StatefulWidget {
  const RegisterThirdPage({Key? key}) : super(key: key);

  @override
  State<RegisterThirdPage> createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
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
              cb: () {},
            )
          ],
        ),
      ),
    );
  }
}
