import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jdshop/model/product_content_model.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';
import '../../config/Config.dart';
import '../../services/event_bus.dart';
class ProductContentFirst extends StatefulWidget {
  final List _productContentList;

  const ProductContentFirst(this._productContentList, {Key? key})
      : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> with AutomaticKeepAliveClientMixin {

  late ProductContentItem _productContent;
  List _attr = [];
  String _selectedValue="";

  @override
  bool get wantKeepAlive => true;

  var actionEventBus;


  @override
  void initState() {
    super.initState();
    _productContent = widget._productContentList[0];
    _attr = _productContent.attr;

    // _initAttr();


    actionEventBus=eventBus.on<ProductContentEvent>().listen((str) {
      if (kDebugMode) {
        print(str);
      }
      _attrBottomSheet();
    });
  }

  @override
  void dispose(){
    super.dispose();
    actionEventBus.cancel();  //取消事件监听
  }

  //初始化Attr 格式化数据
  _initAttr() {
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
      this._attr = attr;
    });
    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
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

  List<Widget> _getAttrItemWidget(attrItem) {
    List<Widget> attrItemList = [];
    attrItem.list.forEach((item) {
      attrItemList.add(Container(
        margin: const EdgeInsets.all(10),
        child: Chip(
          label: Text("$item"),
          padding: const EdgeInsets.all(10),
        ),
      ));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];
    for (var attrItem in _attr) {
      attrList.add(Wrap(
        children: <Widget>[
          SizedBox(
            width: ScreenAdapter.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(28)),
              child: Text("${attrItem.cate}: ",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(
            width: ScreenAdapter.width(580),
            child: Wrap(
              children: _getAttrItemWidget(attrItem),
            ),
          )
        ],
      ));
    }

    return attrList;
  }

  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          //注意：最新版本的Flutter中不存在点击BottomSheet消失的问题，所以外层可以不加GestureDetector事件
          return Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getAttrWidget(),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(96),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: JdButton(
                          color: const Color.fromRGBO(253, 1, 0, 0.9),
                          text: "加入购物车",
                          cb: () {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //处理图片
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
              child: Text(
                  "${_productContent.subTitle}",
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
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: ScreenAdapter.height(80),
            child: InkWell(
              onTap: () {
                _attrBottomSheet();
              },
              child: Row(
                children: const <Widget>[
                  Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("115，黑色，XL，1件")
                ],
              ),
            ),
          ),
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
