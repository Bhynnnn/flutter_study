import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({required this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('에'),
      ),
      body: ListView(
        children: [
          Text('Error: $error'),
          ElevatedButton(
            onPressed: () {},
            child: Text('홈으로'),
          ),
        ],
      ),
    );
  }
}
