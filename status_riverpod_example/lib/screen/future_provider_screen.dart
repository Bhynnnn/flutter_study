import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_riverpod_example/layout/default_layout.dart';
import 'package:status_riverpod_example/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multiplesFutureProvider);
    return DefaultLayout(
      title: 'FutureProviderScreen',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          state.when(
            data: (data) {
              // 로딩이 끝났을 때 실행
              return Text(
                data.toString(),
                textAlign: TextAlign.center,
              );
            },
            error: (err, stack) => Text(
              err.toString(),
            ),
            // 로딩중 일 때 실행
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
