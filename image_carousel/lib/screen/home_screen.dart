import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      Duration(seconds: 3),
      (timer) {
        int? nextPage = pageController.page?.toInt();
        if (nextPage == null) {
          return;
        }

        if (nextPage == 4) {
          nextPage = 0;
        } else {
          nextPage++;
        }
        pageController.animateToPage(nextPage,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      },
    );
  }

  Widget build(BuildContext context) {
    // 상태바 아이콘 색 검 vs 흰
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5]
            .map(
              (number) => Image.asset('asset/img/image_$number.jpeg',
                  fit: BoxFit.cover),
            )
            .toList(),
      ),
    );
  }
}
