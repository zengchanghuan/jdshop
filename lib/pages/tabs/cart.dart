import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/provider/counter.dart';
import 'package:provider/provider.dart';
// import '../../provider/counter.dart';
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          counterProvider.increment();
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text("${counterProvider.count}",style: const TextStyle(
            fontSize: 50
        )),
      ),
    );
  }
}
