import 'package:flutter_riverpod/flutter_riverpod.dart';

final multiplesFutureProvider = FutureProvider<List<int>>((ref) async {
  await Future.delayed(
    Duration(seconds: 2),
  );
  // error 함수 실행을 위한 일부러 에러 던지기
  // throw Exception('에러입니다');

  return [1, 2, 3, 4, 5];
});
