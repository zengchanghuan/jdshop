import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';
class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
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
                if (kDebugMode) {
                  print(value);
                }
              },
            ),
            const SizedBox(height: 20),
            JdButton(
              text: "下一步",
              color: Colors.red,
              height: 74,
              cb: () {
                Navigator.pushNamed(context, '/registerSecond');
              },
            )
          ],
        ),
      ),
    );
  }
}
