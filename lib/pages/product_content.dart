import 'package:flutter/material.dart';
import 'product_content/product_content_first.dart';
import 'product_content/product_content_second.dart';
import 'product_content/product_content_third.dart';
class ProductContentPage extends StatefulWidget {
  final Map arguments;

  const ProductContentPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ProductContentPage> createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              SizedBox(
                width: 250,
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(
                      child: Text('商品'),
                    ),
                    Tab(
                      child: Text('详情'),
                    ),
                    Tab(
                      child: Text('评价'),
                    )
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon:const Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                    context: context,
                    position: const RelativeRect.fromLTRB(
                        600, 76, 10, 0),
                    items: [
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[Icon(Icons.home), Text("首页")],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[Icon(Icons.search), Text("搜索")],
                        ),
                      )
                    ]);
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            const TabBarView(
              children: <Widget>[
                ProductContentFirst(),
                ProductContentSecond(),
                ProductContentThird(),
              ],
            ),
            Positioned(
              width: 750,
              height: 80,
              bottom: 0,
              child: Container(
                color: Colors.red,
                child: const Text("底部"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
