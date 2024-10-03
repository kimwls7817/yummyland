import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 컬렉션에 데이터 추가
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    await _db.collection(collection).add(data);
  }

  // 데이터 가져오기
  Stream<QuerySnapshot> getData(String collection) {
    return _db.collection(collection).snapshots();
  }

  // 데이터 업데이트
  Future<void> updateData(String collection, String docId, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(docId).update(data);
  }

  // 데이터 삭제
  Future<void> deleteData(String collection, String docId) async {
    await _db.collection(collection).doc(docId).delete();
  }
}
