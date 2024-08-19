import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  // main 함수에서 async & await을 사용하려면 WidgetsFlutterBinding.ensureInitialized();를 넣어줘야합니다.

  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isOnBoarded = prefs.getBool("isOnboarded") ?? false;
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Jua'),
      ),
      debugShowCheckedModeBanner: false,
      home: isOnBoarded ? HomePage() : OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            // 페이지1
            // 첫 번째 페이지
            PageViewModel(
              title: "빠른 개발",
              body: "Flutter의 hot reload는 쉽고 UI 빌드를 도와줍니다.",
              image: Padding(
                padding: EdgeInsets.all(32),
                child: Image.network('https://i.ibb.co/2ZQW3Sb/flutter.png'),
              ),
              decoration: PageDecoration(
                titleTextStyle: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                bodyTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            // 두 번째 페이지
            PageViewModel(
              title: "표현력 있고 유연한 UI",
              body: "Flutter에 내장된 아름다운 위젯들로 사용자를 기쁘게 하세요.",
              image: Image.network('https://i.ibb.co/LRpT3RQ/flutter2.png'),
              decoration: PageDecoration(
                titleTextStyle: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                bodyTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          ],
          next: Text("Next", style: TextStyle(fontWeight: FontWeight.w600)),
          done: Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () {
            // When done button is press
            prefs.setBool("isOnboarded", true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              prefs.clear();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Center(
        child: Text(
          '환영합니다!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
