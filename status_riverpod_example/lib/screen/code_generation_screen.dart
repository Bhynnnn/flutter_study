import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_riverpod_example/layout/default_layout.dart';
import 'package:status_riverpod_example/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(number1: 10, number2: 20));
    // final state5 = ref.watch(gStateNotifierProvider);
    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('State1: $state1'),
          state2.when(
            data: (data) {
              // 로딩이 끝났을 때 실행
              return Text(
                'state2: $data',
                textAlign: TextAlign.center,
              );
            },
            error: (err, stack) => Text(
              err.toString(),
            ),
            // 로딩중 일 때 실행
            loading: () => Center(child: CircularProgressIndicator()),
          ),
          state3.when(
            data: (data) {
              // 로딩이 끝났을 때 실행
              return Text(
                'state3: $data',
                textAlign: TextAlign.center,
              );
            },
            error: (err, stack) => Text(
              err.toString(),
            ),
            // 로딩중 일 때 실행
            loading: () => Center(child: CircularProgressIndicator()),
          ),
          Text('state4: $state4'),
          // _StateFiveWidget(),

          Consumer(
            builder: (context, ref, child) {
              final state5 = ref.watch(gStateNotifierProvider);
              return Row(
                children: [
                  Text('state5: $state5'),
                  if (child != null) child,
                ],
              );
            },
            child: Text('hello'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).increment();
                },
                child: Text('increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).decrement();
                },
                child: Text('decrement'),
              )
            ],
          ),
          // invalidate()
          // 유효하지않게하다.
          ElevatedButton(
            onPressed: () {
              ref.invalidate(gStateNotifierProvider);
            },
            child: Text('invalidate'),
          ),
        ],
      ),
    );
  }
}

// class _StateFiveWidget extends ConsumerWidget {
//   const _StateFiveWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state5 = ref.watch(gStateNotifierProvider);
//     return Text('State5: $state5');
//   }
// }
