import 'package:flutter/material.dart';
import '../services/screen_adapter.dart';

class JdText extends StatelessWidget {
  final String text;
  final bool password;
  dynamic onChanged;

  JdText({Key? key, this.text = "输入内容", this.password = false, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: password,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none)),
        onChanged: onChanged,
      ),
      height: ScreenAdapter.height(90),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
    );
  }
}
