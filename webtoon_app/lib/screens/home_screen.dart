import 'package:flutter/material.dart';
import 'package:webtoon_app/models/webtoon_model.dart';
import 'package:webtoon_app/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

// @immutable 메세지 --> final 변수로 변경하기

// Future(비동기)로 api service 이용하기 때문에 StatefulWidget이 아니라 StatelessWidget 사용해도 된다.
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          // snapshot을 이용하면 상태 알 수 있음
          if (snapshot.hasData) {
            // return ListView.builder(
            //     // ListView.builder : 모든 아이템을 한번에 만드는 대신 만들려는 아이템에 itemBuilder 함수 실행 -> 함수 내에서 build 되는 아이템의 인덱스 접근 가능
            //     scrollDirection: Axis.horizontal,
            //     itemCount: snapshot.data!.length,
            //     // itemBuilder : 함수가 인덱스 0 ~ 10 까지만 호출됨 // Recycle
            //     itemBuilder: (context, index) {
            //       var webtoon = snapshot.data![index];
            //       return Text(webtoon.title);
            //     });

            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,

              // itemBuilder : 함수가 인덱스 0 ~ 10 까지만 호출됨 // Recycle
              itemBuilder: (contexxt, index) {
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
              // 사이사이에 widget 넣음
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Builder은 UI를 그리기 위한 함수
      // initialData 전달 가능
    );
  }
}
