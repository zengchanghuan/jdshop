import 'dart:developer';

import 'package:flutter/material.dart';
import '../../provider/counter.dart';
import 'package:provider/provider.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {

    var counterProvider = Provider.of<CountNotifier>(context);
    return Center(
      child: Text("${counterProvider.count}",style: const TextStyle(
          fontSize: 50
      )),
    );  }
}