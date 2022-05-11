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

class _HomePageState extends State<HomePage> {
  List _focusData = [];
  List _hotProductList = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
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

  Widget _recProductItemWidget() {
    final width = MediaQuery.of(context).size.width;
    var itemWidth = (width - 10 - 10 - 10) / 2;
    return Container(
      padding: const EdgeInsets.all(10),
      width: itemWidth,
      decoration: BoxDecoration(
          border: Border.all(
        color: const Color.fromRGBO(233, 233, 233, 0.9),
        width: 1.0,
      )),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                  'https://www.itying.com/images/flutter/list1.jpg',
                  fit: BoxFit.cover),
            ),
          ),
          const Padding(
            child: Text(
              '2022夏季新款气质高贵洋气阔太太有女人味中长款宽松大码',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            padding: EdgeInsets.only(top: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '¥180',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '¥220',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
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
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Wrap(
            runSpacing: 10.0,
            spacing: 10,
            children: [
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
            ],
          ),
        )
      ],
    );
  }
}
