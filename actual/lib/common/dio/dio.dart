import 'package:actual/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  //요청 보낼 때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // print('[REQUEST] [${options.method}] ${options.uri}');
    // print(options);

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    return super.onRequest(options, handler);
  }

  //응답 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RESPONSE] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    return super.onResponse(response, handler);
  }

  //에러 났을 때
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    //401 -> token 재발급 다시 새로운 토큰 요청
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    //refreshtoken 없ㅇ면 에러던짐
    if (refreshToken == null) {
      // 에러 던질 때는 reject사용
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    // 토큰 refresh하다가 난 오류인가? T F
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();
      try {
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;

        options.headers.addAll(
          {
            'authorization': 'Bearer $accessToken',
          },
        );
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        final response = await dio.fetch(options);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
