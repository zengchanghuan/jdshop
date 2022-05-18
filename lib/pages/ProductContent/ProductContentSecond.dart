import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../widget/LoadingWidget.dart';

class ProductContentSecond extends StatefulWidget {
  final List _productContentList;

  const ProductContentSecond(this._productContentList, {Key? key})
      : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond>
    with AutomaticKeepAliveClientMixin {
  dynamic _id;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _id = widget._productContentList[0].sId;
    if (kDebugMode) {
      print(_id);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded(
            child: WebView(
          initialUrl: "https://jdmall.itying.com/pcontent?id=$_id",
        ))
        // Expanded(
        //     child: WebView(
        //       initialUrl:"https://jdmall.itying.com/pcontent?id=5a0425bc010e711234661439",
        //
        //     ))
      ],
    );
  }
}
