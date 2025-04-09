import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  /// Fetch a filtered collection by a specific field and value
  Future<QuerySnapshot> getFilteredCollection({
    required String collection,
    required String field,
    required dynamic value,
  }) async {
    try {
      return await _firestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .get();
    } catch (e) {
      // todo add exception handling
      rethrow;
    }
  }
}
