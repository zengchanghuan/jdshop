import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'Home.dart';
import 'Category.dart';
import 'Cart.dart';
import 'User.dart';

class Tabs extends StatefulWidget {
  Tabs({Key? key}) : super(key: key);

  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  int _currentIndex=0;
  late PageController _pageController;
  @override
  void initState() { 
    super.initState();
    this._pageController=new PageController(initialPage:this._currentIndex );
  }

  List<Widget> _pageList=[
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _currentIndex!=3?AppBar(
        leading: IconButton(
          icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black87),
          onPressed: null,
        ),
        title: InkWell(
          child: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text("笔记本",style: TextStyle(
                  fontSize: ScreenAdapter.size(28)
                ))
              ],
            ),
          ),
          onTap: (){
              Navigator.pushNamed(context, '/search');

          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message, size: 28, color: Colors.black87),
            onPressed: null,
          )
        ],
      ):AppBar(
        title: Text("用户中心"),
      ),
        body: PageView(
          controller: this._pageController,
          children: this._pageList,
          onPageChanged: (index){
            setState(() {
              this._currentIndex=index;
            });
          },
          // physics: NeverScrollableScrollPhysics(),  //禁止pageView滑动，不配置默认可以滑动
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:this._currentIndex ,
          onTap: (index){
              setState(() {
                 this._currentIndex=index;
                 //跳转页面
                 this._pageController.jumpToPage(index);
              });
          },
          type:BottomNavigationBarType.fixed ,
          fixedColor:Colors.red,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页"
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "分类"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "购物车"
            ),            
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "我的"
            )
          ],
        ),     
        
      );
  }
}