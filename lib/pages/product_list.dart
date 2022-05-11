import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  Map? arguments; //Map? 表示arguments是可为空参数

  ProductListPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('商品列表'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (context, index) {
              //每一个元素
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: Image.network(
                            "https://www.itying.com/images/flutter/list2.jpg",
                            fit: BoxFit.cover),
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
                              const Text(
                                  "戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
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
                                      color: const Color.fromRGBO(230, 230, 230, 0.9),
                                    ),

                                    child: const Text("4g"),
                                  ),
                                  Container(
                                    height: 36,
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      borderRadius:  BorderRadius.circular(10),
                                      color: const Color.fromRGBO(230, 230, 230, 0.9),
                                    ),
                                    child: const Text("126"),
                                  ),
                                ],
                              ),
                              const Text(
                                "¥990",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 20)
                ],
              );
            },
            itemCount: 10,
          ),
        ));
    // body:Text("${widget.arguments}")
  }
}
