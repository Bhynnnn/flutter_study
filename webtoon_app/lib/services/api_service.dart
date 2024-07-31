import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  void getTodaysToons() async {
    // baseUrl + today endpoint 로 URL 만들기
    final url = Uri.parse('$baseUrl/$today');
    // await : 서버에서 요청 처리하고 응답주는거 기다린 후 response에 저장
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
