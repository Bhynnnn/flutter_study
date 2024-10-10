import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BucketService extends ChangeNotifier {
  final bucketCollection = FirebaseFirestore.instance.collection('bucket');

  Future<QuerySnapshot> read(String uid) async {
    return bucketCollection.where('uid', isEqualTo: uid).get();
  }

  void create(String job, String uid) async {
    await bucketCollection.add({
      'uid': uid,
      'job': job,
      'isDone': false,
    });
    notifyListeners();
  }

  void update(String docId, bool isDone) async {
    await bucketCollection.doc(docId).update({'isDone': isDone});
    notifyListeners();
  }

  void delete(String docId) async {
    await bucketCollection.doc(docId).delete();
    notifyListeners();
  }
}
