import 'package:flutter/material.dart';
import '../../services/screen_adapter.dart';
import '../../widget/jd_button.dart';
import '../../widget/jd_text.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressAddPage extends StatefulWidget {
  const AddressAddPage({Key? key}) : super(key: key);

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("增加收货地址"),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20),
              JdText(
                text: "收货人姓名",
              ),
              const SizedBox(height: 10),
              JdText(
                text: "收货人电话",
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 5),
                height: ScreenAdapter.height(68),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12))),
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.add_location),
                      area.isNotEmpty
                          ? Text(area,
                              style: const TextStyle(color: Colors.black54))
                          : const Text('省/市/区',
                              style: TextStyle(color: Colors.black54))
                    ],
                  ),
                  onTap: () async {
                    //最新版本的Flutter注意返回的类型  需要判断是否为空
                    Result? result = await CityPickers.showCityPicker(
                        context: context,
                        cancelWidget:
                            const Text("取消", style: TextStyle(color: Colors.blue)),
                        confirmWidget:
                            const Text("确定", style: TextStyle(color: Colors.blue)));

                    // print(result);
                    setState(() {
                      if (result != null) {
                        area =
                            "${result.provinceName}/${result.cityName}/${result.areaName}";
                      }
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              JdText(
                text: "详细地址",
                maxLines: 4,
                height: 200,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 40),
              const JdButton(text: "增加", color: Colors.red)
            ],
          ),
        ));
  }
}
