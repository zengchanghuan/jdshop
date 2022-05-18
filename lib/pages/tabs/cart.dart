import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/counter.dart';
import '../cart/cart_item.dart';
import '../cart/cart_num.dart';
import '../../provider/cart.dart';

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
    var counterProvider = Provider.of<CountNotifier>(context);
    var cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.increment();
          cartProvider.addData('哈哈${counterProvider.count}');
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Center(
            child: Text("统计数量：${counterProvider.count}",style: const TextStyle(
                fontSize: 20
            )),
          ),
          const Divider(),

          //加载购物车列表的子组件
          const CartItem(),
          const Divider(height: 40),
          const CartNum()
        ],
      ),
    );
  }
}
