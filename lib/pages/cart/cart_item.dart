import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);

    return cartProvider.cartList.isNotEmpty
        ? Column(
            children: cartProvider.cartList.map((value) {
              return ListTile(
                title: Text("$value"),
                trailing: InkWell(
                  onTap: () {
                    //删除
                    cartProvider.deleteData(value);
                  },
                  child: const Icon(Icons.delete),
                ),
              );
            }).toList(),
          )
        : const Text("");
  }
}
