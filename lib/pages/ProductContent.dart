import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/ScreenAdapter.dart';
import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThird.dart';

import '../widget/JdButton.dart';

import '../config/Config.dart';
import 'package:dio/dio.dart';
import '../model/ProductContentModel.dart';

import '../widget/LoadingWidget.dart';
import '../services/event_bus.dart';
import '../services/cart_services.dart';
import '../provider/cart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;

  const ProductContentPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  final List _productContentList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(this._productContentData.sId);

    _getContentData();
  }

  _getContentData() async {
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';

    print(api);
    var result = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(result.data);
    // print(productContent.result.pic);

    // print(productContent.result.title);

    setState(() {
      _productContentList.add(productContent.result);
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
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
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        ScreenAdapter.width(600), 76, 10, 0),
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
                    ]);
              },
            )
          ],
        ),
        body: _productContentList.isNotEmpty
            ? Stack(
                children: <Widget>[
                  TabBarView(
                    physics:
                        const NeverScrollableScrollPhysics(), //禁止 pageView 滑动
                    children: <Widget>[
                      ProductContentFirst(_productContentList),
                      ProductContentSecond(_productContentList),
                      const ProductContentThird()
                    ],
                  ),
                  Positioned(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.width(88),
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black26, width: 1)),
                          color: Colors.white),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/cart');
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.only(top: ScreenAdapter.height(10)),
                              width: 100,
                              height: ScreenAdapter.height(88),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.shopping_cart,
                                    size: ScreenAdapter.size(36),
                                  ),
                                  Text("购物车",
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.size(24)))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: const Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () async {
                                //广播
                                if (_productContentList[0].attr.length > 0) {
                                  eventBus.fire(ProductContentEvent('加入购物车'));
                                } else {
                                  await CartServices.addCart(_productContentList[0]);
                                  //调用Provider 更新数据
                                  cartProvider.updateCartList();
                                  if (kDebugMode) {
                                    print('加入购物车');
                                  }
                                }
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: const Color.fromRGBO(255, 165, 0, 0.9),
                              text: "立即购买",
                              cb: () {
                                //广播
                                if (_productContentList[0].attr.length > 0) {
                                  eventBus.fire(ProductContentEvent('立即购买'));
                                } else {
                                  if (kDebugMode) {
                                    print('立即购买');
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : const LoadingWidget(),
      ),
    );
  }
}
