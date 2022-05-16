import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThird.dart';
import '../widget/JdButton.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;
  const ProductContentPage({Key? key, required this.arguments}) : super(key: key);

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
              SizedBox(
                width: ScreenAdapter.width(400),
                child: const TabBar(
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
              icon: const Icon(Icons.more_horiz),
              onPressed: (){
                showMenu(
                    context:context,
                    position:RelativeRect.fromLTRB(ScreenAdapter.width(600), 76, 10, 0) ,
                    items: [
                        PopupMenuItem(
                          child: Row(
                            children: const <Widget>[
                              Icon(Icons.home),
                              Text("首页")
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: const <Widget>[
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

            const TabBarView(
                children: <Widget>[
                  ProductContentFirst(),
                  ProductContentSecond(),
                  ProductContentThird()
                ],
             ),
             Positioned(
               width: ScreenAdapter.width(750),
               height: ScreenAdapter.width(88), //注意：里面元素的总高度不能大于外部元素的高度
               bottom: 0,
               child: Container(               
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black26,
                      width: 1
                    )
                  ),
                  color: Colors.white
                ),
                child: Row(
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(top:ScreenAdapter.height(8)),
                      width: 100,
                      height: ScreenAdapter.height(80),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.shopping_cart,size:ScreenAdapter.size(38)),
                          Text("购物车",style: TextStyle(fontSize:ScreenAdapter.size(24)))
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: JdButton(
                        color:const Color.fromRGBO(253, 1, 0, 0.9),
                        text: "加入购物车",
                        cb: (){
                          print('加入购物车');
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: JdButton(
                        color: const Color.fromRGBO(255, 165, 0, 0.9),
                        text: "立即购买",
                        cb: (){
                          if (kDebugMode) {
                            print('立即购买');
                          }
                        },
                      ),
                    )

                  ],
                ),
               ),
             )
          ],
        ),
      ),
    );
  }
}
