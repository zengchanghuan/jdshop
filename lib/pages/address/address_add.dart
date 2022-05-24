import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/screen_adapter.dart';
import '../../widget/jd_button.dart';
import '../../widget/jd_text.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../services/event_bus.dart';
import '../../services/user_services.dart';
import '../../services/sign_services.dart';
import '../../config/config.dart';

class AddressAddPage extends StatefulWidget {
  const AddressAddPage({Key? key}) : super(key: key);

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  String name = '';
  String phone = '';
  String address = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                onChanged: (value) {
                  name = value;
                },
              ),
              const SizedBox(height: 10),
              JdText(
                text: "收货人电话",
                onChanged: (value) {
                  phone = value;
                },
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
                        cancelWidget: const Text("取消",
                            style: TextStyle(color: Colors.blue)),
                        confirmWidget: const Text("确定",
                            style: TextStyle(color: Colors.blue)));

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
                onChanged: (value) {
                  address = "$area $value";
                },
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 40),
              JdButton(
                  text: "增加",
                  color: Colors.red,
                  cb: () async {
                    List userinfo = await UserServices.getUserInfo();

                    if (kDebugMode) {
                      print(userinfo);
                    }

                    // print('1234');
                    var tempJson = {
                      "uid": userinfo[0]["_id"],
                      "name": name,
                      "phone": phone,
                      "address": address,
                      "salt": userinfo[0]["salt"]
                    };

                    var sign = SignServices.getSign(tempJson);
                    // print(sign);

                    var api = '${Config.domain}api/addAddress';
                    var result = await Dio().post(api, data: {
                      "uid": userinfo[0]["_id"],
                      "name": name,
                      "phone": phone,
                      "address": address,
                      "sign": sign
                    });

                    // if(result.data["success"]){

                    // }
                    Navigator.pop(context);
                  })
            ],
          ),
        ));
  }
}
