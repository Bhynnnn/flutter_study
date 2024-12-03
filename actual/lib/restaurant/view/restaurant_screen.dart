import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    print('run');
    // 현재 위치가 최대 길이보다 조금 덜 되는 위치까지 왔다면
    // 새로운 데이터를 추가요청

    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);
    // 완전 처음 로딩일 때
    if (data is CursorPaginationLoading) {
      return Center(child: CircularProgressIndicator());
    }
    // error
    if (data is CursorPaginationError) {
      return Center(child: Text(data.message));
    }

    // CursorPagination ( meta, data )
    // CursorPaginationFetchingMore ( meta, data )
    // CursorPaginationRefetching ( meta, data )
    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.separated(
        controller: controller,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            // 마지막 index + 1일 때
            return Center(
                child: data is CursorPaginationFetchingMore
                    ? CircularProgressIndicator()
                    : Text('마지막 데이터 입니다.'));
          }
          final pItem = cp.data[index];
          return GestureDetector(
              onTap: () {
                // Card누르면 navigate to detail Screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => RestaurantDetailScreen(id: pItem.id)),
                );
              },
              child: RestaurantCard.fromModel(model: pItem));
        },
        itemCount: cp.data.length + 1,
        separatorBuilder: (_, index) {
          return SizedBox(
            height: 16.0,
          );
        },
      ),
    );
  }
}
