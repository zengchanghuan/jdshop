import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/services/cart_services.dart';
import 'package:provider/provider.dart';
import '../../services/screen_adapter.dart';
import '../../widget/jd_button.dart';

import '../../model/product_content_model.dart';

import '../../config/config.dart';
import '../../services/event_bus.dart';
import '../ProductContent/cart_number.dart';
import '../../provider/cart_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductContentFirst extends StatefulWidget {
  final List _productContentList;

  const ProductContentFirst(this._productContentList, {Key? key})
      : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  late ProductContentitem _productContent;

  List _attr = [];

  String _selectedValue = "";

  @override
  bool get wantKeepAlive => true;
  dynamic actionEventBus;

  dynamic cartProvider;

  @override
  void initState() {
    super.initState();
    _productContent = widget._productContentList[0];

    _attr = _productContent.attr;

    _initAttr();

    //监听所有广播
    actionEventBus = eventBus.on<ProductContentEvent>().listen((str) {
      if (kDebugMode) {
        print(str);
      }
      _attrBottomSheet();
    });

    //[{"cate":"鞋面材料","list":["牛皮 "]},{"cate":"闭合方式","list":["系带"]},{"cate":"颜色","list":["红色","白色","黄色"]}]

    // list":["系带","非系带"]

    /*
    [

        {
        "cate":"尺寸",
        list":[{

              "title":"xl",
              "checked":false
            },
            {

              "title":"xxxl",
              "checked":true
            },
          ]
        },
        {
        "cate":"颜色",
        list":[{

              "title":"黑色",
              "checked":false
            },
            {

              "title":"白色",
              "checked":true
            },
          ]
        }
    ]
   */
  }

  @override
  void dispose() {
    super.dispose();
    actionEventBus.cancel();
  }

  //初始化Attr 格式化数据
  _initAttr() {
    //注意attrList属性需要在model中定义
    var attr = _attr;
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }
    if (kDebugMode) {
      print(attr[0].attrList);
      print(attr[0].cate);
      print(attr[0].list);
    }

    _getSelectedAttrValue();
  }

  //改变属性值
  _changeAttr(cate, title, setBottomState) {
    var attr = _attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
      _attr = attr;
    });
    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var _list = _attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].attrList.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]["title"]);
        }
      }
    }
    // print(tempArr.join(','));
    setState(() {
      _selectedValue = tempArr.join(',');
    });
  }

  //循环具体属性
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            _changeAttr(attrItem.cate, item["title"], setBottomState);
          },
          child: Chip(
            label: Text(
              "${item["title"]}",
              style: TextStyle(
                  color: item["checked"] ? Colors.white : Colors.black54),
            ),
            padding: const EdgeInsets.all(10),
            backgroundColor: item["checked"] ? Colors.red : Colors.black26,
          ),
        ),
      ));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    for (var attrItem in _attr) {
      attrList.add(Wrap(
        children: <Widget>[
          SizedBox(
            width: ScreenAdapter.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(22)),
              child: Text("${attrItem.cate}: ",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            width: ScreenAdapter.width(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          )
        ],
      ));
    }

    return attrList;
  }

  //底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(ScreenAdapter.width(20)),
                    child: ListView(
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _getAttrWidget(setBottomState)),
                        const Divider(),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: ScreenAdapter.height(80),
                          child: Row(
                            children: <Widget>[
                              const Text("数量: ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              CartNum(_productContent)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.height(76),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: JdButton(
                              color: const Color.fromRGBO(253, 1, 0, 0.9),
                              text: "加入购物车",
                              cb: () async {
                                await CartServices.addCart(_productContent);
                                Navigator.of(context).pop();
                                cartProvider.updateCartList();
                                Fluttertoast.showToast( msg: '加入购物车成功', toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER,);
                                if (kDebugMode) {
                                  print('加入购物车');
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: JdButton(
                                color: const Color.fromRGBO(255, 165, 0, 0.9),
                                text: "立即购买",
                                cb: () {
                                  if (kDebugMode) {
                                    print('立即购买');
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);

    //处理图片
    super.build(context);
    String pic = Config.domain + _productContent.pic;
    pic = pic.replaceAll('\\', '/');

    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Image.network(pic, fit: BoxFit.cover),
          ),
          //标题
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text("${_productContent.title}",
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenAdapter.size(36))),
          ),
          Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text("${_productContent.subTitle}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenAdapter.size(28)))),
          //价格
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      const Text("特价: "),
                      Text("¥${_productContent.price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.size(46))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text("原价: "),
                      Text("¥${_productContent.oldPrice}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.size(28),
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          _attr.isNotEmpty
              ? Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: ScreenAdapter.height(80),
                  child: InkWell(
                    onTap: () {
                      _attrBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        const Text("已选: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(_selectedValue)
                      ],
                    ),
                  ),
                )
              : const Text(""),
          const Divider(),
          SizedBox(
            height: ScreenAdapter.height(80),
            child: Row(
              children: const <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
