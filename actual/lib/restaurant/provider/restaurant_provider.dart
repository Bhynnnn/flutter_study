import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/provider/pagination_provider.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhereOrNull((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);
    return notifier;
  },
);

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    // 만약 데이터가 아직 하나도 없는 상태라면(CursorPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await this.paginate();
    }
    // state가 CursorPagination이 아닐 떄 그냥 return

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final resp = await repository.getRestaurantDetail(id: id);

    // [Restaurant(1), Restaurant(2), Restaurant(3)] 이 있다고 했을 떄 Restaurant(2)의 Detail을 가져와라
    // getDetail(id:10)
    // list.where((e) => e.id == 10)) 데이터 없음
    // [Restaurant(1), RestaurantDetailModel(2), Restaurant(3), RestaurantDetailModel(10)]
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(data: <RestaurantModel>[
        ...pState.data,
        resp,
      ]);
    } else {
      // [Restaurant(1), Restaurant(2), Restaurant(3)] 이 있다고 했을 떄 Restaurant(2)의 Detail을 가져와라
      // getDetail(id:2)
      // [Restaurant(1), RestaurantDetailModel(2), Restaurant(3)]
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? resp : e)
            .toList(),
      );
    }
  }
}
