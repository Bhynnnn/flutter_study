import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Miso 메인 색상
Color misoPrimaryColor = const Color.fromARGB(255, 38, 103, 240);

class Miso extends StatefulWidget {
  const Miso({super.key});

  @override
  _MisoState createState() => _MisoState();
}

class _MisoState extends State<Miso> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex, // index 순서에 해당하는 child를 맨 위에 보여줌
        children: const [
          MisoFirstPage(),
          MisoSecondPage(),
          MisoThirdPage(),
          MisoFourthPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex, // 현재 보여주는 탭
        onTap: (newIndex) {
          print("selected newIndex : $newIndex");
          // 다른 페이지로 이동
          setState(() {
            currentIndex = newIndex;
          });
        },
        selectedItemColor: misoPrimaryColor, // 선택된 아이콘 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 아이콘 색상
        showSelectedLabels: false, // 선택된 항목 label 숨기기
        showUnselectedLabels: false, // 선택되지 않은 항목 label 숨기기
        type: BottomNavigationBarType.fixed, // 선택시 아이콘 움직이지 않기
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.redeem), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}

/// 첫 번째 페이지
class MisoFirstPage extends StatelessWidget {
  const MisoFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: misoPrimaryColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '대한민국 1등 홈서비스\n 미소를 만나보세요!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('+ 예약하기 버튼 tap');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 120,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: misoPrimaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '예약하기',
                            style: TextStyle(
                              color: misoPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 30,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.white.withOpacity(0.3),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '서비스 상세정보',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 두 번째 페이지
class MisoSecondPage extends StatelessWidget {
  const MisoSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 100,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '예약내역',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.error,
                          color: misoPrimaryColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '예약된 서비스가 아직 없어요. 지금 예약해보세요!',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey)
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: misoPrimaryColor,
                      alignment: Alignment.center,
                      child: Text(
                        '예약하기',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
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

/// 세 번째 페이지
class MisoThirdPage extends StatelessWidget {
  const MisoThirdPage({super.key});

  /// 세 번째 화면 배경 이미지 URL
  final String backgroundImgUrl =
      "https://i.ibb.co/rxzkRTD/146201680-e1b73b36-aa1e-4c2e-8a3a-974c2e06fa9d.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: misoPrimaryColor,
      body: Center(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 400,
                    ),
                    child: Image.network(backgroundImgUrl),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 64,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 28,
                          height: 1.5,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: '친구 추천할 때마다\n',
                          ),
                          TextSpan(
                            text: '10,000원 ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '할인쿠폰 지급!',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("자세히 보기 클릭 됨");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '자세히 보기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 30,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.gift_fill,
                            color: misoPrimaryColor,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '친구 추천하기',
                            style: TextStyle(
                              color: misoPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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

/// 네 번째 페이지
class MisoFourthPage extends StatelessWidget {
  const MisoFourthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 70,
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '나의 정보',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '010-1234-5678',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.all(0),
                horizontalTitleGap: 30,
                leading: Icon(Icons.home_outlined, color: Colors.black),
                title: Text(
                  "주소 관리",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.all(0),
                horizontalTitleGap: 30,
                leading: Icon(Icons.credit_card, color: Colors.black),
                title: Text(
                  "결제 수단 관리",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.all(0),
                horizontalTitleGap: 30,
                leading: Icon(CupertinoIcons.speaker_3, color: Colors.black),
                title: Text(
                  "공지사항",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding: EdgeInsets.all(0),
                horizontalTitleGap: 30,
                leading:
                    Icon(CupertinoIcons.question_circle, color: Colors.black),
                title: Text(
                  "문의사항",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
