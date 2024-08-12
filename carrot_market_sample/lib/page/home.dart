import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> datas = [];
  
  @override
  void initState() {
    super.initState();
    datas = [];
  }


  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      centerTitle: false,
      title: GestureDetector(
        onTap: () {
          print("click");
        },
        child: const Row(
          children: [
            Text('아라동'),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.tune),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/svg/bell.svg",
            width: 22,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: Container(),
      bottomNavigationBar: Container(),
    );
  }
}
