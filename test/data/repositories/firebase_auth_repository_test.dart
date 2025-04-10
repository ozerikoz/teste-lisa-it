import 'package:flutter_test/flutter_test.dart';
import 'package:teste_lisa_it/data/repositories/auth/firebase_auth_repository.dart';
import 'package:teste_lisa_it/data/services/auth/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuthService extends Mock implements FirebaseAuthService {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late FirebaseAuthRepository authRepository;
  late MockFirebaseAuthService mockAuthService;
  late MockUser mockUser;
  late MockUserCredential mockUserCredential;

  setUp(() {
    // Initialize mocks and repository
    mockAuthService = MockFirebaseAuthService();
    mockUser = MockUser();
    mockUserCredential = MockUserCredential();
    authRepository =
        FirebaseAuthRepository(firebaseAuthService: mockAuthService);

    // Mock user properties
    when(() => mockUser.uid).thenReturn('DGHA45C7B2HDM3');
    when(() => mockUser.displayName).thenReturn('Mock User');
    when(() => mockUser.email).thenReturn('mock.user@gmail.com');
    when(() => mockUser.photoURL)
        .thenReturn('https://via.placeholder.com/600/92c952');
    when(() => mockUserCredential.user).thenReturn(mockUser);
  });

  group('FirebaseAuthRepository - login', () {
    test('Successful login', () async {
      // Mock FirebaseAuthService login method
      when(() => mockAuthService.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockUserCredential);

      // Execute the login method
      final user = await authRepository.login(
        email: 'mock.user@gmail.com',
        password: 'password123',
      );

      // Verify the result
      expect(user.userUid, 'DGHA45C7B2HDM3');
      expect(user.name, 'Mock User');
      expect(user.email, 'mock.user@gmail.com');
      expect(user.profileImageUrl, 'https://via.placeholder.com/600/92c952');
    });
  });

  group('FirebaseAuthRepository - isAuthenticated', () {
    test('Should return user when authenticated', () async {
      // Mock FirebaseAuthService getCurrentUser method
      when(() => mockAuthService.getCurrentUser()).thenReturn(mockUser);

      // Execute the isAuthenticated method
      final result = await authRepository.isAuthenticated();

      // Verify the result is the correct user
      expect(result, isNotNull);
    });

    test('Should return null when not authenticated', () async {
      // Mock FirebaseAuthService getCurrentUser method to return null
      when(() => mockAuthService.getCurrentUser()).thenReturn(null);

      // Execute the isAuthenticated method
      final result = await authRepository.isAuthenticated();

      // Verify the result is null
      expect(result, isNull);
    });
  });

  group('FirebaseAuthRepository - logout', () {
    test('Successful logout', () async {
      // Mock FirebaseAuthService logout method
      when(() => mockAuthService.logout()).thenAnswer((_) async => {});

      // Execute the logout method
      await authRepository.logout();

      // Verify that the logout method was called
      verify(() => mockAuthService.logout()).called(1);
    });
  });
}
