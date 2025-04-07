import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_lisa_it/data/services/auth/firebase_auth_service.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late FirebaseAuthService firebaseAuthService;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    // Initialize mocks and firebase auth service
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    firebaseAuthService = FirebaseAuthService(firebaseAuth: mockFirebaseAuth);
  });

  group("FirebaseAuthService", () {
    const testEmail = "test@gmail.com";
    const testPassword = "password123";

    test("login should return UserCredential when authentication is successful",
        () async {
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).thenAnswer((_) async => mockUserCredential);

      final result = await firebaseAuthService.login(
        email: testEmail,
        password: testPassword,
      );

      expect(result, equals(mockUserCredential));
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: testEmail,
            password: testPassword,
          )).called(1);
    });

    test("logout should call signOut when executed successfully", () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      await firebaseAuthService.logout();

      verify(() => mockFirebaseAuth.signOut()).called(1);
    });

    test("getCurrentUser should return the current user when available", () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

      final result = firebaseAuthService.getCurrentUser();

      expect(result, equals(mockUser));
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });

    test("getCurrentUser should return null when no user is logged in", () {
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      final result = firebaseAuthService.getCurrentUser();

      expect(result, isNull);
      verify(() => mockFirebaseAuth.currentUser).called(1);
    });
  });
}
