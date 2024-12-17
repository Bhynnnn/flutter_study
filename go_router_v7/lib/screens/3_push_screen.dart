import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: ListView(
      children: [
        ElevatedButton(
          // context.push -> 위로 올려 스택 쌓기
          // basic screen의 root가 push screen
          onPressed: () {
            context.push('/basic');
          },
          child: Text('Push Basic'),
        ),
        ElevatedButton(
          // context.go -> root의 위로 올리기 (스택 x)
          // basic screen에서 뒤로가기 하면 root screen 나옴
          onPressed: () {
            context.go('/basic');
          },
          child: Text('Go Basic'),
        ),
      ],
    ));
  }
}
