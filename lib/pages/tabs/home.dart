import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/widgets.dart';
import '../../model/focus_model.dart';
import 'package:jdshop/services/screen_adaper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _focusData = [];

  void initState() {
    super.initState();
    _getFocusData();
  }

  _getFocusData() async {
    var api = 'http://jdmall.itying.com/api/focus';
    var result = await Dio().get(api);

    var foucsList = FocusModel.fromJson(result.data);

    // foucsList.result.forEach((value) {
    //   print(value.title);
    //   print(value.pic);
    // });

    setState(() {
      _focusData = foucsList.result;
    });
  }

  //轮播图
  Widget _swiperWidget() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = _focusData[index].pic;
              return new Image.network(
                "https://jdmall.itying.com/${pic.replaceAll('\\', '/')}",
                fit: BoxFit.fill,
              );
            },
            itemCount: _focusData.length,
            pagination: SwiperPagination(),
            autoplay: true),
      ),
    );

    // List<Map> imgList = [
    //   {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
    //   {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
    //   {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    // ];
  }

  Widget _titleWidget(value) {
    return Container(
      height: 32.0,
      margin: EdgeInsets.only(left: 10.0),
      padding: EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: 10.0,
      ))),
      child: Text(
        value,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _hotProductListWidget() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(5.0),
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 140,
                width: 140,
                margin: EdgeInsets.only(right: 4.0),
                child: Image.network(
                    "https://www.itying.com/images/flutter/hot${index + 1}.jpg",
                    fit: BoxFit.cover),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                height: 44.0,
                child: Text("第${index}条"),
              ),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

  Widget _recProductItemWidget() {
    final width = MediaQuery.of(context).size.width;
    var itemWidth = (width - 10 - 10 - 10) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      width: itemWidth,
      decoration: BoxDecoration(
          border: Border.all(
        color: Color.fromRGBO(233, 233, 233, 0.9),
        width: 1.0,
      )),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                  'https://www.itying.com/images/flutter/list1.jpg',
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
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
            padding: EdgeInsets.only(top: 10),
            child: Stack(
              children: [
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
        SizedBox(height: 20.0),
        _titleWidget('猜你喜欢'),
        SizedBox(height: 20.0),
        _hotProductListWidget(),
        _titleWidget('热门推荐'),
        Container(
          padding: EdgeInsets.all(10.0),
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
