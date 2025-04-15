import 'package:firebase_core/firebase_core.dart';
import 'package:teste_lisa_it/config/firebase_options.dart';
import 'package:teste_lisa_it/core/exceptions/exceptions.dart';

/// A service class for initializing and managing Firebase
class FirebaseService {
  /// Private constructor to enforce singleton pattern
  FirebaseService._();

  /// The single instance of [FirebaseService]
  static final FirebaseService _instance = FirebaseService._();

  /// Provides access to the single instance of [FirebaseService]
  factory FirebaseService() => _instance;

  /// Tracks if Firebase has already been initialized
  static bool _isInitialized = false;

  /// Initializes Firebase with the provided options.
  static Future<void> initializeFirebase() async {
    if (_isInitialized) {
      // Firebase is already initialized, no need to initialize again
      return;
    }

    try {
      await Firebase.initializeApp(
        name: "test-lisa-it",
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Mark Firebase as initialized
      _isInitialized = true;
    } on FirebaseException {
      rethrow;
    } catch (e, s) {
      throw UnknownException("Failed to initialize Firebase: $e", s);
    }
  }
}
