import 'package:flutter/material.dart';
import 'package:jdshop/services/ScreenAdapter.dart';
import 'package:jdshop/widget/JdButton.dart';
import '../widget/JdText.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // title: Text("登录页面"),
        actions: <Widget>[
          TextButton(
            child: Text("客服"),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                height: ScreenAdapter.width(160),
                width: ScreenAdapter.width(160),
                child: Image.asset('images/login.png',fit: BoxFit.cover),
                // child: Image.network(
                //     'https://www.itying.com/images/flutter/list5.jpg',
                //     fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 30),
            JdText(
              text: "请输入用户名",
              onChanged: (value) {
                print(value);
              },
            ),
            const SizedBox(height: 10),
            JdText(
              text: "请输入密码",
              password: true,
              onChanged: (value) {
                print(value);
              },
            ),

            const SizedBox(height: 10),

            Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              child: Stack(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('忘记密码'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/registerFirst');
                      },
                      child: const Text('新用户注册'),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),
            JdButton(
              text:"登录",
              color: Colors.red,
              height: 74,
              cb: (){

              },
            )
          ],
        ),
      ),
    );
  }
}
