import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';
//test1
// 1. 어떤 provider를 사용할 지 결정할 고민 할 필요 없도록
// provider? futureProvider?
// StateNotifierProvider

//test
// final _testProvider = Provider((ref) => 'Hello Code Generation');

@riverpod
String gState(GStateRef ref) {
  return 'Hello Code Generation';
}

@riverpod
Future<int> gStateFuture(GStateFutureRef ref) async {
  await Future.delayed(
    Duration(seconds: 3),
  );
  return 10;
}

// keepAlive : 살려둬라 -->  AutoDispose 안되게해라
@Riverpod(keepAlive: true)
Future<int> gStateFuture2(GStateFuture2Ref ref) async {
  await Future.delayed(
    Duration(seconds: 3),
  );
  return 10;
}

// 2. Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록

class Parameter {
  final int number1;
  final int number2;

  Parameter({
    required this.number1,
    required this.number2,
  });
}

final _testFamailyProvider = Provider.family<int, Parameter>(
  (ref, Parameter) => Parameter.number1 * Parameter.number2,
);

@riverpod
int gStateMultiply(
  GStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}

@riverpod
class gStateNotifier extends _$gStateNotifier {
  @override
  int build() {
    return 0;
  }

  increment() {
    state++;
  }

  decrement() {
    state--;
  }
}
