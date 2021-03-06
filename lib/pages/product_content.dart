import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/screen_adapter.dart';
import 'ProductContent/product_content_first.dart';
import 'ProductContent/product_content_second.dart';
import 'ProductContent/product_content_third.dart';

import '../widget/jd_button.dart';

import '../config/config.dart';
import 'package:dio/dio.dart';
import '../model/product_content_model.dart';

import '../widget/loading_widget.dart';
import '../services/event_bus.dart';
import '../services/cart_services.dart';
import '../provider/cart_provider.dart';
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
    var cartProvider = Provider.of<CartProvider>(context);
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
                      child: Text('??????'),
                    ),
                    Tab(
                      child: Text('??????'),
                    ),
                    Tab(
                      child: Text('??????'),
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
                            Text("??????")
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.search),
                            Text("??????")
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
                        const NeverScrollableScrollPhysics(), //?????? pageView ??????
                    children: <Widget>[
                      ProductContentFirst(_productContentList),
                      ProductContentSecond(_productContentList),
                      const ProductContentThird()
                    ],
                  ),
                  Positioned(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.width(120),
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.black26, width: 1)),
                          color: Colors.white),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/cart');
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: ScreenAdapter.height(10)),
                              width: 100,
                              height: ScreenAdapter.height(88),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.shopping_cart,
                                    size: ScreenAdapter.size(30),
                                  ),
                                  Text("?????????",
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
                              text: "???????????????",
                              cb: () async {
                                //??????
                                if (_productContentList[0].attr.length > 0) {
                                  eventBus.fire(ProductContentEvent('???????????????'));
                                } else {
                                  await CartServices.addCart(
                                      _productContentList[0]);
                                  //??????Provider ????????????
                                  cartProvider.updateCartList();
                                  Fluttertoast.showToast(
                                    msg: '?????????????????????',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  if (kDebugMode) {
                                    print('???????????????');
                                  }
                                }
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: JdButton(
                              color: const Color.fromRGBO(255, 165, 0, 0.9),
                              text: "????????????",
                              cb: () {
                                //??????
                                if (_productContentList[0].attr.length > 0) {
                                  eventBus.fire(ProductContentEvent('????????????'));
                                } else {
                                  if (kDebugMode) {
                                    print('????????????');
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
