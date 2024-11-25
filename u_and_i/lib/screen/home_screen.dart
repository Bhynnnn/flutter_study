import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
}

class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'U & I',
          style: textTheme.headlineLarge,
        ),
        SizedBox(height: 10),
        Text('우리 처음 만난날', style: textTheme.bodyLarge),
        Text('yyyy.mm.dd', style: textTheme.bodyMedium),
        SizedBox(height: 20),
        Icon(Icons.favorite, color: Colors.red),
        SizedBox(height: 20),
        Text('D+365', style: textTheme.headlineMedium)
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      'asset/img/middle_image.png',
      height: MediaQuery.of(context).size.height / 2,
    ));
  }
}
