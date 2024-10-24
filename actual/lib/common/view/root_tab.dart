import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    // vsync - with SingleTickerProviderStateMixin 설정 해줘야한대요...
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "코팩 딜리버리",
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (int index) {
          print(index);
          setState(() {
            this.index = index;
          });
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
      child: TabBarView(
        controller: controller,
        children: [
          Center(child: Container(child: Text('홈'))),
          Center(child: Container(child: Text('음식'))),
          Center(child: Container(child: Text('주문'))),
          Center(child: Container(child: Text('프로필'))),
        ],
      ),
    );
  }
}
