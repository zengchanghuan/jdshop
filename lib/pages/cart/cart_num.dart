import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';

class CartNum extends StatefulWidget {
  const CartNum({Key? key}) : super(key: key);

  @override
  State<CartNum> createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Column(
      children: [Text("${cartProvider.cartNum}")],
    );
  }
}
