import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../config/config.dart';
import '../model/product_model.dart';
import '../widget/loading_widget.dart';

class ProductListPage extends StatefulWidget {
  Map? arguments; //Map? 表示arguments是可为空参数

  ProductListPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController _scrollController = ScrollController();
  List _productList = [];

  //分页
  int _page = 1;

  //每页有多少条数据
  final int _pageSize = 8;

  //  排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  String _sort = "";

  //解决重复请求的问题
  bool _flag = true;

  //是否有数据
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _getProductListData();

    //监听滚动条滚动事件
    _scrollController.addListener(() {
      //获取滚动条的高度
      // _scrollController.position.pixels;
      // _scrollController.position.maxScrollExtent

      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        //加载更多
        if (_flag && _hasMore) {
          _getProductListData();
        }
      }
    });
  }

  //获取商品列表的数据
  _getProductListData() async {

    setState(() {
      _flag = false;
    });
    var api =
        '${Config.domain}api/plist?cid=${widget.arguments!["cid"]}&page=$_page&sort=$_sort&pageSize=$_pageSize';

    if (kDebugMode) {
      print(api);
    }
    var result = await Dio().get(api);

    var productList = ProductModel.fromJson(result.data);

    if (kDebugMode) {
      print(productList.result);
    }

    if (productList.result.length < _pageSize) {
      setState(() {
        _productList.addAll(productList.result);
        _hasMore = false;
        _flag = false;
      });
    } else {
      setState(() {
        _productList.addAll(productList.result);
        _page++;
        _flag = true;
      });
    }
  }

  //显示加载中的圈圈
  Widget _showMore(index) {
    if (_hasMore) {
      return (index == _productList.length - 1)
          ? const LoadingWidget()
          : const Text("");
    } else {
      return (index == _productList.length - 1)
          ? const Text("--我是有底线的--")
          : const Text("");
    }
  }

//商品列表
  Widget _productListWidget() {
    if (_productList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 80),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            //处理图片
            String pic = _productList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            //每一个元素
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: Image.network(pic, fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 180,
                        margin: const EdgeInsets.only(left: 10),
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${_productList[index].title}",
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 36,

                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),

                                  //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9),
                                  ),

                                  child: const Text("4g"),
                                ),
                                Container(
                                  height: 36,
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromRGBO(
                                        230, 230, 230, 0.9),
                                  ),
                                  child: const Text("126"),
                                ),
                              ],
                            ),
                            Text(
                              "¥${_productList[index].price}",
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(height: 20),
                _showMore(index)
              ],
            );
          },
          itemCount: _productList.length,
        ),
      );
    } else {
      return const LoadingWidget();
    }
  }

  //筛选导航
  Widget _subHeaderWidget() {
    final width = MediaQuery.of(context).size.width;
    return Positioned(
      top: 0,
      height: 80,
      width: width,
      child: Container(
        width: width,
        height: 80,
        // color: Colors.red,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: Text("销量", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: Text("价格", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: Text("筛选", textAlign: TextAlign.center),
                ),
                onTap: () {
                  //注意：新版本中ScaffoldState? 为可空类型 注意判断
                  if (_scaffoldKey.currentState != null) {
                    _scaffoldKey.currentState!.openEndDrawer();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("商品列表"),
          leading: IconButton(
            //注意：新版本的Flutter中加入Drawer组件会导致默认的返回按钮失效，所以需要手动加上返回按钮
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: const <Widget>[Text("")],
        ),
        endDrawer: const Drawer(
          child: Text("实现筛选功能"),
        ),
        body: Stack(
          children: <Widget>[
            _productListWidget(),
            _subHeaderWidget(),
          ],
        ));
  }
}
