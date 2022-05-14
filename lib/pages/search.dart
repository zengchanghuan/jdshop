import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/search_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _keywords;
  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    _getHistoryData();
  }

  _getHistoryData() async {
    var _historyListData = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData = _historyListData;
    });
  }

  _showAlertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("提示信息!"),
            content: const Text("您确定要删除吗?"),
            actions: <Widget>[
              TextButton(
                child: const Text("取消"),
                onPressed: () {
                  if (kDebugMode) {
                    print("取消");
                  }
                  Navigator.pop(context, 'Cancle');
                },
              ),
              TextButton(
                child: const Text("确定"),
                onPressed: () async {
                  //注意异步 删除本地记录
                  await SearchServices.removeHistoryData(keywords);
                  _getHistoryData();
                  Navigator.pop(context, "Ok");
                },
              )
            ],
          );
        });
    //  print(result);
  }

  Widget _historyListWidget() {
    if (_historyListData.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("历史记录", style: Theme.of(context).textTheme.subtitle1),
          const Divider(),
          Column(
            children: _historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("$value"),
                    onLongPress: () {
                      _showAlertDialog("$value");
                    },
                  ),
                  const Divider()
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  SearchServices.clearHistoryList();
                  _getHistoryData();
                },
                child: Container(
                  width: 380,
                  height: 64,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text("清空历史记录"),
                      Icon(Icons.delete),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      );
    } else {
      return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)),
              onChanged: (value) {
                _keywords = value;
              },
            ),
            height: 48,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
          ),
          actions: <Widget>[
            InkWell(
              child: SizedBox(
                height: 68,
                width: 80,
                child: Row(
                  children: const <Widget>[Text("搜索")],
                ),
              ),
              onTap: () {
                //保存本地存储
                SearchServices.setHistoryData(_keywords);
                Navigator.pushReplacementNamed(context, '/productList',
                    arguments: {"keywords": _keywords});
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Text("热搜", style: Theme.of(context).textTheme.subtitle1),
              const Divider(),
              Wrap(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("笔记本电脑"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装111"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  )
                ],
              ),
              const SizedBox(height: 10),
              _historyListWidget()
            ],
          ),
        ));
  }
}
