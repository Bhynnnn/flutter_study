import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_riverpod_example/layout/default_layout.dart';
import 'package:status_riverpod_example/riverpod/provider.dart';
import 'package:status_riverpod_example/riverpod/state_notifier_provider.dart';

class ProviderScreen extends ConsumerWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(filteredShoppingListProvider);
    print(state);
    return DefaultLayout(
      title: 'ProviderScreen',
      actions: [
        PopupMenuButton<FilterState>(
          itemBuilder: (_) => FilterState.values
              .map(
                (e) => PopupMenuItem(
                  value: e,
                  child: Text(
                    e.name,
                  ),
                ),
              )
              .toList(),
          onSelected: (value) {
            print(value);
            ref.read(filterProvider.notifier).update((state) => value);
          },
        ),
      ],
      body: ListView(
        children: state
            .map(
              (e) => CheckboxListTile(
                title: Text(e.name),
                onChanged: (value) {
                  ref
                      .read(shoppingListProvider.notifier)
                      .toggleHasBought(name: e.name);
                },
                value: e.hasBought,
              ),
            )
            .toList(),
      ),
    );
  }
}
