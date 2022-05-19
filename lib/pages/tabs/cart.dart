import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/cart_item.dart';
import '../../services/ScreenAdapter.dart';
import '../../provider/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("cart");
    }
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("购物车"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.launch),
            onPressed: () {
              setState(() {
                _isEdit = !_isEdit;
              });
            },
          )
        ],
      ),
      body: cartProvider.cartList.isNotEmpty
          ? Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Column(
                        children: cartProvider.cartList.map((value) {
                      return CartItem(value);
                    }).toList()),
                    SizedBox(height: ScreenAdapter.height(100))
                  ],
                ),
                Positioned(
                  bottom: 0,
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(78),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black12)),
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
                                  value: cartProvider.isCheckedAll,
                                  activeColor: Colors.pink,
                                  onChanged: (val) {
                                    cartProvider.checkAll(val);
                                  },
                                ),
                              ),
                              const Text("全选"),
                              const SizedBox(width: 20),
                              _isEdit == false
                                  ? const Text("合计:")
                                  : const Text(""),
                              _isEdit == false
                                  ? Text("${cartProvider.allPrice}",
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.red))
                                  : const Text(""),
                            ],
                          ),
                        ),
                        _isEdit == false
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  child: const Text("结算",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {},
                                ),
                              )
                            : Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  child: const Text("删除",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    cartProvider.removeItem();
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: Text("购物车空空的..."),
            ),
    );
  }
}
