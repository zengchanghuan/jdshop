import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThird.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  ProductContentPage({Key? key, required this.arguments}) : super(key: key);

  _ProductContentPageState createState() => _ProductContentPageState();
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
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(400),
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
              icon: Icon(Icons.more_horiz),
              onPressed: (){
                showMenu(
                    context:context,
                    position:RelativeRect.fromLTRB(ScreenAdapter.width(600), 76, 10, 0) ,
                    items: [
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.home),
                              Text("首页")
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.search),
                              Text("搜索")
                            ],
                          ),
                        )
                    ]
                );
              },
            )

          ],
        ),
        body: Stack(

          children: <Widget>[

            TabBarView(
                children: <Widget>[
                  ProductContentFirst(),
                  ProductContentSecond(),
                  ProductContentThird()
                ],
             ),
             Positioned(
               width: ScreenAdapter.width(750),
               height: ScreenAdapter.width(80),
               bottom: 0,
               child: Container(
                 color: Colors.red,
                  child: Text(
                    "底部"
                  ),
               ),
             )
          ],
        ),
      ),
    );
  }
}
