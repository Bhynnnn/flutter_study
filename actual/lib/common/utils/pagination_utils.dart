import 'package:actual/common/provider/pagination_provider.dart';
import 'package:flutter/widgets.dart';

class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      print('paginate');
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}
