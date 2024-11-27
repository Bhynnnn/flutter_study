import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_riverpod_example/layout/default_layout.dart';
import 'package:status_riverpod_example/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(selectProvider);

// isSpicy 값만 watch 하면서 변경되면 새로 렌더링 해라
    final state2 = ref.watch(selectProvider.select((value) => value.isSpicy));
    ref.listen(selectProvider.select((value) => value.hasBought),
        (previous, next) {
      print('next: $next');
    });
    return DefaultLayout(
        title: 'SelectProviderScreen',
        body: Column(
          children: [
            Text(
              state.name,
            ),
            Text(
              state.isSpicy.toString(),
            ),
            Text(
              state.hasBought.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleIsSpicy();
              },
              child: Text('Spicy Toggle'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectProvider.notifier).toggleHasBought();
              },
              child: Text('hasBought Toggle'),
            ),
            Text(state2.toString()),
          ],
        ));
  }
}
