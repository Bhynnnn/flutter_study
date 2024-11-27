import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_riverpod_example/layout/default_layout.dart';
import 'package:status_riverpod_example/model/shopping_item_model.dart';
import 'package:status_riverpod_example/riverpod/state_notifier_provider.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ShoppingItemModel> state = ref.watch(shoppingListProvider);

    return DefaultLayout(
      title: 'StateNotifierProvieder',
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
