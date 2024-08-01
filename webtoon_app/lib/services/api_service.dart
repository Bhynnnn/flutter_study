import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_app/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    // baseUrl + today endpoint 로 URL 만들기
    final url = Uri.parse('$baseUrl/$today');
    // await : 서버에서 요청 처리하고 응답주는거 기다린 후 response에 저장
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // type Dynamic == any
      final List<dynamic> webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
