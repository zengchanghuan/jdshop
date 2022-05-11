// import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

// import 'package:flutter/widgets.dart';
import '../../model/focus_model.dart';
import '../../model/product_model.dart';
import '../../config/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {


  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  //轮播图数据
  _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);

    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      _focusData = focusList.result;
    });
  }

  //猜你喜欢数据
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      _hotProductList = hotProductList.result;
    });
  }

  //获取热门推荐的数据
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      _bestProductList = bestProductList.result;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    if (_focusData.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = _focusData[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return Image.network(
                pic,
                fit: BoxFit.fill,
              );
            },
            itemCount: _focusData.length,
            pagination: const SwiperPagination(),
            autoplay: true),
      );
    } else {
      return const Text('加载中...');
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: 32.0,
      margin: const EdgeInsets.only(left: 10.0),
      padding: const EdgeInsets.only(left: 10.0),
      decoration: const BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: 10.0,
      ))),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _hotProductListWidget() {
    if (_hotProductList.isNotEmpty) {
      return Container(
        height: 234,
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            //处理图片
            String sPic = _hotProductList[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');

            return Column(
              children: <Widget>[
                Container(
                  height: 140,
                  width: 140,
                  margin: const EdgeInsets.only(right: 21),
                  child: Image.network(sPic, fit: BoxFit.cover),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 44,
                  child: Text(
                    "¥${_hotProductList[index].price}",
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          itemCount: _hotProductList.length,
        ),
      );
    } else {
      return const Text("loading……");
    }
  }

  //推荐商品
  Widget _recProductListWidget() {

    final width = MediaQuery.of(context).size.width;
    var itemWidth = (width - 10 - 10 - 10) / 2;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: _bestProductList.map((value) {

          //图片
          String sPic=value.sPic;
          sPic=Config.domain+sPic.replaceAll('\\', '/');

          return Container(
            padding: const EdgeInsets.all(10),
            width: itemWidth,
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    //防止服务器返回的图片大小不一致导致高度不一致问题
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      sPic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "${value.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "¥${value.price}",
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text( "¥${value.oldPrice}",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough)),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _swiperWidget(),
        const SizedBox(height: 20.0),
        _titleWidget('猜你喜欢'),
        const SizedBox(height: 20.0),
        _hotProductListWidget(),
        _titleWidget('热门推荐'),
        _recProductListWidget(),
      ],
    );
  }


}
