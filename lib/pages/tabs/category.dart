import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;

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
        Container(
          width: leftWidth,
          height: double.infinity,
          color: Colors.white54,
          child: ListView.builder(
            itemCount: 28,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = index;
                      });
                    },
                    child: Container(
                      height: 56,
                      width: double.infinity,
                      child: Text(
                        '第$index',
                        textAlign: TextAlign.center,
                      ),
                      color: _selectIndex == index ? Colors.red : Colors.white,
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
        Expanded(
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
              itemCount: 28,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image.network(
                          "https://www.itying.com/images/flutter/list8.jpg",
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      height: 28,
                      child: Text("女装"),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
