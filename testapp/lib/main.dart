import 'package:flutter/material.dart';
import 'package:testapp/screen/home_screen.dart';
import 'package:testapp/widget/bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netfilx',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.redAccent,
        ),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              Container(child: Center(child: Text('search'),),),
              Container(child: Center(child: Text('save'),),),
              Container(child: Center(child: Text('more'),),),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
