import 'package:bucket_list_with_firebase/auth_service.dart';
import 'package:bucket_list_with_firebase/bucket_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => BucketService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? LoginPage() : Homepage(),
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
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        final user = authService.currentUser();
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
                    user == null ? "로그인 해주세요🌞" : "${user.email}님 안녕하세요 🤩",
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
                    authService.signIn(
                      email: emailController.text,
                      password: passwordController.text,
                      onSuccess: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('로그인 성공'),
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Homepage()),
                        );
                      },
                      onError: (err) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(err),
                          ),
                        );
                      },
                    );
                    // 로그인 성공시 HomePage로 이동
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
                  onPressed: () {
                    authService.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      onSuccess: () {
                        print("회원가입 성공");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("회원가입 성공"),
                          ),
                        );
                      },
                      onError: (err) {
                        print("회원가입 실패 : $err");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(err),
                          ),
                        );
                      },
                    );
                  },
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
      },
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    final user = authService.currentUser()!;
    return Consumer<BucketService>(
      builder: (context, bucketService, child) {
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
                  context.read<AuthService>().signOut();
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
                          bucketService.create(jobController.text, user.uid);
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
                child: FutureBuilder<QuerySnapshot>(
                    future: bucketService.read(user.uid),
                    builder: (context, snapshot) {
                      final documents = snapshot.data?.docs ?? [];
                      if (documents.isEmpty) {
                        return Center(child: Text("버킷 리스트를 작성해주세요."));
                      }
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          final doc = documents[index];
                          String job = doc.get('job');
                          bool isDone = doc.get('isDone');
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
                              onPressed: () {
                                bucketService.delete(doc.id);
                              },
                            ),
                            onTap: () {
                              bucketService.update(doc.id, !isDone);
                            },
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
