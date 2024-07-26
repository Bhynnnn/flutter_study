import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;

  void onPressed() {
    setState(() {
      // build method 재호출
      counter = counter + 1;
    });

//////꼭 setState() 안에 상태 변화 안넣어도 됨
    // counter = counter + 1;
    // setState(() {
    //   // build method 재호출
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Click Count',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              '$counter',
              style: const TextStyle(fontSize: 30),
            ),
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.add_box_rounded),
              iconSize: 40,
            )
          ],
        )),
      ),
    );
  }
}