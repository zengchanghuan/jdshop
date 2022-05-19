import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../cart/cart_item.dart';
import '../../services/ScreenAdapter.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("cart");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("购物车"),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: null,
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: const <Widget>[CartItem(), CartItem(), CartItem()],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(78),
            child: Container(
              decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(width: 1, color: Colors.black12)),
                color: Colors.white,
              ),
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(78),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: ScreenAdapter.width(60),
                          child: Checkbox(
                            value: true,
                            activeColor: Colors.pink,
                            onChanged: (val) {},
                          ),
                        ),
                        const Text("全选")
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      child: const Text("结算",
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
