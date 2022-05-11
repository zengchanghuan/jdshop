import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/config.dart';
import '../../model/cate_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;
  List _leftCateList = [];

  List _rightCateList = [];

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    // print(leftCateList.result);
    setState(() {
      _leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[0].sId);
  }

  //右侧分类
  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=$pid';
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    // print(rightCateList.result);
    setState(() {
      _rightCateList = rightCateList.result;
    });
  }

  Widget _leftCateWidget(leftWidth) {
    if (_leftCateList.isNotEmpty) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        color: Colors.white54,
        child: ListView.builder(
          itemCount: _leftCateList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectIndex = index;
                      _getRightCateData(_leftCateList[index].sId);
                    });
                  },
                  child: Container(
                    height: 84,
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "${_leftCateList[index].title}",
                      textAlign: TextAlign.center,
                    ),
                    color: _selectIndex == index
                        ? const Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
              ],
            );
          },
        ),
      );
    } else {
      return SizedBox(width: leftWidth, height: double.infinity);
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.isNotEmpty) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: double.infinity,
          color: const Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth / rightItemHeight,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: _rightCateList.length,
            itemBuilder: (context, index) {
              //处理图片
              String pic = _rightCateList[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');

              return Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(pic, fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 28,
                    child: Text("${_rightCateList[index].title}"),
                  )
                ],
              );
            },
          ),
        ),
      );
    } else {
      return Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            color: const Color.fromRGBO(240, 246, 246, 0.9),
            child: const Text("加载中..."),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //左侧宽度
    var leftWidth = width / 4;
    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3

    var rightItemWidth = (width - leftWidth - 20 - 20) / 3;
    var rightItemHeight = rightItemWidth + 28;

    return Row(
      children: [
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight),
      ],
    );
  }
}
