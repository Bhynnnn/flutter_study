import 'package:flutter/material.dart';
import 'package:webtoon_app/models/webtoon_model.dart';
import 'package:webtoon_app/services/api_service.dart';

import '../widgets/webtoon_widget.dart';

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
            //     // 필요할때 호출함 like paging
            //     // ListView.builder : 모든 아이템을 한번에 만드는 대신 만들려는 아이템에 itemBuilder 함수 실행 -> 함수 내에서 build 되는 아이템의 인덱스 접근 가능
            //     scrollDirection: Axis.horizontal,
            //     itemCount: snapshot.data!.length,
            //     // itemBuilder : 함수가 인덱스 0 ~ 10 까지만 호출됨 // Recycle
            //     itemBuilder: (context, index) {
            //       var webtoon = snapshot.data![index];
            //       return Text(webtoon.title);
            //     });

            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
              ],
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

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      // itemBuilder : 함수가 인덱스 0 ~ 10 까지만 호출됨 // Recycle
      itemBuilder: (contexxt, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      // 사이사이에 widget 넣음
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}

///////// ERROR //////////
// HTTP request failed, statusCode: 403, https://image-comic.pstatic.net/webtoon/814048/thumbnail/thumbnail_IMAG21_234ffc80-64de-4765-b059-6888ae0a9fae.jpg
// 에러의 원인

// 따로 User-Agent 값을 추가하지 않으면 기본값으로 `Dart/<version> (dart:io)` 가 들어갑니다.
// (https://api.flutter.dev/flutter/dart-io/HttpClient/userAgent.html)

// 이 값을 지우고 브라우저에서 사용하는 값으로 바꿔줍니다.
// (브라우저 값이 아니면 네이버에서 차단하는걸로 보입니다)

// 방법 1. (local? override)
// [home_screen.dart]
// headers에 useragent 추가
// ...
// child: Image.network(
//   webtoon.thumb,
//   headers: const {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",},
// ),
