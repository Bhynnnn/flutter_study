import 'package:actual/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  static List<String> listPathsToUrls(List<dynamic>? paths) {
    if (paths == null) return [];
    return paths.map((e) => pathToUrl(e)).toList();
  }
}
