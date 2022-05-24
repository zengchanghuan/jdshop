import 'package:flutter/material.dart';
import '../../services/screen_adapter.dart';
class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('收货地址列表'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.check, color: Colors.red),
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("张三  15201681234"),
                      SizedBox(height: 10),
                      Text("北京市海淀区西二旗"),
                    ]),
                trailing: const Icon(Icons.edit, color: Colors.blue),
              ),
              const Divider(height: 20),
              ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("张三  15201xxxx234"),
                      SizedBox(height: 10),
                      Text("北京市海defdsafaf西二旗"),
                    ]),
                trailing: const Icon(Icons.edit, color: Colors.blue),
              ),
              const Divider(height: 20),
              ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("张三  15201xxxx234"),
                      SizedBox(height: 10),
                      Text("北京市海defdsafaf西二旗"),
                    ]),
                trailing: const Icon(Icons.edit, color: Colors.blue),
              ),
              const Divider(height: 20),
              ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("张三  15201xxxx234"),
                      SizedBox(height: 10),
                      Text("北京市海defdsafaf西二旗"),
                    ]),
                trailing: const Icon(Icons.edit, color: Colors.blue),
              ),
              const Divider(height: 20),
              ListTile(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("张三  15201xxxx234"),
                      SizedBox(height: 10),
                      Text("北京市海defdsafaf西二旗"),
                    ]),
                trailing: const Icon(Icons.edit, color: Colors.blue),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(88),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(88),
              decoration: const BoxDecoration(
                  color: Colors.red,
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.black26))),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.add, color: Colors.white),
                    Text("增加收货地址", style: TextStyle(color: Colors.white))
                  ],
                ),
                onTap: (){
                  Navigator.pushNamed(context,'/addressAdd');
                },
              ),
            ),
          )
        ],
      ),

    );
  }
}

