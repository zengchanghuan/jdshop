import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  const CartNum({Key? key}) : super(key: key);

  @override
  State<CartNum> createState() => _CartNumState();
}

//左侧按钮
Widget _leftBtn() {
  return InkWell(
    onTap: () {},
    child: Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(45),
      height: ScreenAdapter.height(45),
      child: const Text("-"),
    ),
  );
}

//右侧按钮
Widget _rightBtn() {
  return InkWell(
    onTap: () {},
    child: Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(45),
      height: ScreenAdapter.height(45),
      child: const Text("+"),
    ),
  );
}

//中间
Widget _centerArea() {
  return Container(
    alignment: Alignment.center,
    width: ScreenAdapter.width(70),
    decoration: const BoxDecoration(
        border: Border(
      left: BorderSide(width: 1, color: Colors.black12),
      right: BorderSide(width: 1, color: Colors.black12),
    )),
    height: ScreenAdapter.height(45),
    child: const Text("1"),
  );
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(164),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_leftBtn(), _centerArea(), _rightBtn()],
      ),
    );
  }
}
