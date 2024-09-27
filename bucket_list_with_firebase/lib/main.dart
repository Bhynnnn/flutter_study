import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// 현재 유저 로그인 상태
            Center(
              child: Text(
                "로그인해 주세요 🙂",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 32),

            /// 이메일
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: "이메일"),
            ),

            /// 비밀번호
            TextField(
              controller: passwordController,
              obscureText: false, // 비밀번호 안보이게
              decoration: InputDecoration(hintText: "비밀번호"),
            ),
            SizedBox(height: 32),

            /// 로그인 버튼
            ElevatedButton(
              onPressed: () {
                // 로그인 성공시 HomePage로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => Homepage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(33, 150, 243, 1)),
              child: Text(
                "로그인",
                style: TextStyle(fontSize: 21, color: Colors.white),
              ),
            ),

            /// 회원가입 버튼
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(33, 150, 243, 1)),
              child: Text(
                "회원가입",
                style: TextStyle(fontSize: 21, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController jobController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        title: Text(
          "버킷 리스트",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              print("sign out");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              "로그아웃",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: jobController,
                    decoration: InputDecoration(hintText: "하고싶은 일을 입력해주세요"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (jobController.text.isNotEmpty) {
                      print('create bucket');
                    }
                  },
                  child: Icon(Icons.add),
                )
              ],
            ),
          ),
          Divider(height: 1),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                String job = "$index";
                bool isDone = false;
                return ListTile(
                  title: Text(
                    job,
                    style: TextStyle(
                      fontSize: 24,
                      color: isDone ? Colors.blue : Colors.black,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(CupertinoIcons.delete),
                    onPressed: () {},
                  ),
                  onTap: () {},
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
