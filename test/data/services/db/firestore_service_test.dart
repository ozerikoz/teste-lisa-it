import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_test/flutter_test.dart";
import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:teste_lisa_it/data/services/db/firestore_service.dart";

void main() {
  late FirestoreService firestoreService;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    // Initialize fake firestore and service
    fakeFirestore = FakeFirebaseFirestore();
    firestoreService = FirestoreService(firestore: fakeFirestore);
  });

  group("FirestoreService", () {
    const testCollection = "users";
    const testField = "email";
    const testValue = "test@gmail.com";

    test("getFilteredCollection should return QuerySnapshot when successful",
        () async {
      // add test data to the fake firestore
      await fakeFirestore
          .collection(testCollection)
          .add({"email": "test@gmail.com", "name": "test User"});
      await fakeFirestore
          .collection(testCollection)
          .add({"email": "other@gmail.com", "name": "other User"});

      final result = await firestoreService.getFilteredCollection(
        collection: testCollection,
        field: testField,
        value: testValue,
      );

      expect(result, isA<QuerySnapshot<Map<String, dynamic>>>());
      expect(result.docs.length, equals(1));

      final docData = result.docs.first.data() as Map<String, dynamic>;

      expect(docData["email"], equals(testValue));
      expect(docData["name"], equals("test User"));
    });
  });
}
