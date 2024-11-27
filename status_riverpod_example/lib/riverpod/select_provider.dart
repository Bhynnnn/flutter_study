import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:status_riverpod_example/model/shopping_item_model.dart';

final selectProvider = StateNotifierProvider<SelectNotifier, ShoppingItemModel>(
    (ref) => SelectNotifier());

class SelectNotifier extends StateNotifier<ShoppingItemModel> {
  SelectNotifier()
      : super(
          ShoppingItemModel(
              name: '김치', quantity: 3, hasBought: false, isSpicy: true),
        );

  toggleHasBought() {
    state = state.copyWith(hasBought: !state.hasBought);
  }

  // toggleIsSpicy() {
  //   // final ts = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  //   // final ts2 = ts.copyWith(fontSize: 18.0);

  //   state = ShoppingItemModel(
  //     name: state.name,
  //     quantity: state.quantity,
  //     hasBought: state.hasBought,
  //     isSpicy: !state.isSpicy,
  //   );
  // }

  toggleIsSpicy() {
    state = state.copyWith(isSpicy: !state.isSpicy);
  }
}
