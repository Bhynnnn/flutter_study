import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text(
            'Hello Flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.network(
                    "https://i.ibb.co/CwzHq4z/trans-logo-512.png",
                    width: 81,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: '이메일'),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: '비밀번호'),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 16,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade400,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Text('로그인'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
