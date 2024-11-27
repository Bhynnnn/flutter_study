import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_riverpod_example/layout/default_layout.dart';
import 'package:status_riverpod_example/riverpod/state_provider.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: Text('UP'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(numberProvider.notifier).state =
                    ref.read(numberProvider.notifier).state - 1;
              },
              child: Text('DOWN'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => _NextScreen()));
              },
              child: Text('nextPage'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
      title: 'StateProviderScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                // 이 전 화면인 DefaultLayout에서도 같은 numberProvider을 사용하고 있기 때문에 화면이 NextScreen으로 넘어왔어도 같은 값을 가질 수 밖에 없음.
                // DefaultLayout에서 버튼을 눌러 numberProvider의 숫자를 변경 해 놨어도 NextScreen으로 넘어왔을 때 가지는 numberProvider의 값은 동일 할 수 밖에 없다.
                ref.read(numberProvider.notifier).update((state) => state + 1);
              },
              child: Text('UP'),
            ),
          ],
        ),
      ),
    );
  }
}
