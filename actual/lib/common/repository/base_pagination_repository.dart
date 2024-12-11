import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/model/model_with_id.dart';
import 'package:actual/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  //  Future<CursorPagination<RestaurantModel>> paginate({
  // @Queries() PaginationParams? paginationParams = const PaginationParams(),
  // });

  // paginate 함수 호출 시 CursorPagination<Model> 일반화를 위해 Generic type 이용해서 추상 클래스 만들어줌

  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
