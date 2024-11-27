import 'package:flutter_riverpod/flutter_riverpod.dart';
// 캐시 삭제
// 자동으로 삭제함
// 원래 이미 한번 로딩 된 데이터들은 다음 로딩 시 이미 저장 된 값들을 가지고 오는데 dispose 키워드를 넣어줘서 사용하지 않을 때 캐시 삭제 시킴

final autoDisposeModifierProvider =
    FutureProvider.autoDispose<List<int>>((ref) async {
  await Future.delayed(Duration(seconds: 2));
  return [1, 2, 3, 4, 5, 6];
});
