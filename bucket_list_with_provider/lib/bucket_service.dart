import 'package:flutter/material.dart';

import 'main.dart';

/// Bucket 담당
/// BucketService의 bucketList가 변경되는 경우 해당 값을 보여주는 화면들을 갱신시켜 주는 기능을 구현하기 위해
/// ChangeNotifier 클래스의 기능을 물려 받았습니다.
/// ChangeNotifier를 상속 받은 경우 notifylisteners();를 호출하여 위젯들을 갱신하는 기능을 사용할 수 있음
class BucketService extends ChangeNotifier {
  List<Bucket> bucketList = [
    Bucket('잠자기', false), // 더미(dummy) 데이터
  ];

  void createBucket(String job) {
    bucketList.add(Bucket(job, false));
    // 갱신 = Consumer<BucketService>의 builder 부분만 새로고침
    // builder: (context, bucketService, child) 호출
    notifyListeners();
  }

  void updateBucket(Bucket bucket, int index) {
    bucketList[index] = bucket;
    notifyListeners();
  }

  void deleteBucket(int index) {
    bucketList.remove(index);
    notifyListeners();
  }
}
