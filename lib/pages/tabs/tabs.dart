import 'package:flutter/material.dart';
import 'home.dart';
import 'cart.dart';
import 'category.dart';
import 'user.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;

  PageController? _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  final List<Widget> _pageList = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _currentIndex!=3?AppBar(
          leading: const IconButton(
            icon: Icon(Icons.center_focus_weak, size: 28, color: Colors.black87),
            onPressed: null,
          ),
          title: InkWell(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(233, 233, 233, 0.8),
                  borderRadius: BorderRadius.circular(30)
              ),
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Icon(Icons.search),
                  Text("笔记本",style: TextStyle(
                      fontSize: 20
                  ))
                ],
              ),
            ),
            onTap: (){
              Navigator.pushNamed(context, '/search');

            },
          ),
          actions: const <Widget>[
            IconButton(
              icon: Icon(Icons.message, size: 28, color: Colors.black87),
              onPressed: null,
            )
          ],
        ):AppBar(
          title: const Text("用户中心"),
        ),
      body:  PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: (index){
          setState(() {
            _currentIndex=index;
          });
        },
        // physics: NeverScrollableScrollPhysics(),  //禁止pageView滑动，不配置默认可以滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        // backgroundColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController?.jumpToPage(_currentIndex);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: '分类',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '购物车',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
