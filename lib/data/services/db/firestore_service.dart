import "package:cloud_firestore/cloud_firestore.dart";
import "package:teste_lisa_it/core/exceptions/exceptions.dart";
import "package:teste_lisa_it/data/exceptions/firestore_exceptions.dart";

/// A service class for interacting with Firestore
class FirestoreService {
  /// The [Firestore] instance used for database operations
  final FirebaseFirestore _firestore;

  FirestoreService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Fetch a filtered collection by a specific field and value
  ///
  /// - [collection] is the name of the collection to fetch
  /// - [field] is the field to filter by
  /// - [value] is the value to filter by
  Future<QuerySnapshot> getFilteredCollection({
    required String collection,
    required String field,
    required dynamic value,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw FirestoreException(
          "No documents found in collection $collection with $field=$value",
        );
      }

      return querySnapshot;
    } on FirebaseException catch (e, s) {
      throw FirestoreException(e.message ?? e.code, e.code, s);
    } catch (e, s) {
      throw UnknownException(
        "An unexpected error occurred while fetching collection $collection: $e",
        s,
      );
    }
  }
}
