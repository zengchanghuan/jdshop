import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdaper {
  static height(num value) {
    return ScreenUtil().setHeight(value);
  }

  static width(num value) {
    return ScreenUtil().setWidth(value);
  }

  static size(num value) {
    return ScreenUtil().setSp(value);
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth; //获取设备的物理宽度
  }

  static getScreenHeight() {
    return ScreenUtil().screenHeight; //获取设备的物理高度
  }
}

/*
class ScreenAdaper {
  static init(context){
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }
  static height(double value){
    return ScreenUtil.getInstance().setHeight(value);
  }
  static width(double value){
    return ScreenUtil.getInstance().setWidth(value);
  }
  static getScreenHeight(){
    return ScreenUtil.screenHeightDp;
  }
  static getScreenWidth(){
    return ScreenUtil.screenWidthDp;
  }
}
*/