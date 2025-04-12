import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:provider/provider.dart";
import "package:teste_lisa_it/config/firebase_options.dart";
import "package:teste_lisa_it/core/dependencies.dart";
import "package:teste_lisa_it/main.dart";
import "package:teste_lisa_it/presentation/auth/login/pages/login_page.dart";
import "package:teste_lisa_it/presentation/home/pages/home_page.dart";
import "package:teste_lisa_it/presentation/home/pages/post/post_details_page.dart";
import "package:teste_lisa_it/presentation/home/pages/post/post_user_profile_page.dart";
import "package:teste_lisa_it/presentation/home/widgets/post_card.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Initialize Firebase before running tests
    await Firebase.initializeApp(
      name: "test-lisa-it",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  tearDown(() async {
    // Delete the Firebase app instance after each test
    await FirebaseAuth.instance.signOut();
  });

  group("end-to-end test", () {
    testWidgets("Should load app", (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        MultiProvider(
          providers: dependencies,
          child: const MainApp(),
        ),
      );

      // Wait for the app to load
      await tester.pumpAndSettle();

      // Login screen because logget out
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets("Perform login", (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        MultiProvider(
          providers: dependencies,
          child: const MainApp(),
        ),
      );

      // Wait for the app to load
      await tester.pumpAndSettle();

      // Login screen because logget out
      expect(find.byType(LoginPage), findsOneWidget);

      // Find the email and password fields
      final emailField = find.byKey(const ValueKey("email-field"));
      final passwordField = find.byKey(const ValueKey("password-field"));

      // Enter valid credentials
      await tester.enterText(emailField, 'user.teste@gmail.com');
      await tester.enterText(passwordField, 'Teste@123');

      // Wait for the text fields to update
      await tester.pumpAndSettle();

      // Find the login button
      final loginButton = find.byKey(const ValueKey("login-button"));

      // Tap the login button
      await tester.tap(loginButton);

      // Wait for the login process to complete
      await tester.pumpAndSettle();

      // Verify that the login was successful and the home page is displayed
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets("Perform Posts Pagination on HomePage", (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        MultiProvider(
          providers: dependencies,
          child: const MainApp(),
        ),
      );

      // Wait for the app to load
      await tester.pumpAndSettle();

      // Login screen because logget out
      expect(find.byType(LoginPage), findsOneWidget);

      // Find the email and password fields
      final emailField = find.byKey(const ValueKey("email-field"));
      final passwordField = find.byKey(const ValueKey("password-field"));

      // Enter valid credentials
      await tester.enterText(emailField, 'user.teste@gmail.com');
      await tester.enterText(passwordField, 'Teste@123');

      // Wait for the text fields to update
      await tester.pumpAndSettle();

      // Find the login button
      final loginButton = find.byKey(const ValueKey("login-button"));

      // Tap the login button
      await tester.tap(loginButton);

      // Wait for the login process to complete
      await tester.pumpAndSettle();

      // Verify that the login was successful and the home page is displayed
      expect(find.byType(HomePage), findsOneWidget);

      // Wait for the home page to load
      await tester.pumpAndSettle();

      // Scroll the list until the 11th post is visible
      await tester.scrollUntilVisible(
        find.byKey(ValueKey('post-card-11')),
        500.0,
        scrollable: find.byType(Scrollable),
      );

      // Wait for the scroll to complete
      await tester.pumpAndSettle();

      expectLater(find.byKey(ValueKey('post-card-11')), findsOneWidget);
    });

    testWidgets("Navigate to PostDetailsPage", (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        MultiProvider(
          providers: dependencies,
          child: const MainApp(),
        ),
      );

      // Wait for the app to load
      await tester.pumpAndSettle();

      // Login screen because logget out
      expect(find.byType(LoginPage), findsOneWidget);

      // Find the email and password fields
      final emailField = find.byKey(const ValueKey("email-field"));
      final passwordField = find.byKey(const ValueKey("password-field"));

      // Enter valid credentials
      await tester.enterText(emailField, 'user.teste@gmail.com');
      await tester.enterText(passwordField, 'Teste@123');

      // Wait for the text fields to update
      await tester.pumpAndSettle();

      // Find the login button
      final loginButton = find.byKey(const ValueKey("login-button"));

      // Tap the login button
      await tester.tap(loginButton);

      // Wait for the login process to complete
      await tester.pumpAndSettle();

      // Verify that the login was successful and the home page is displayed
      expect(find.byType(HomePage), findsOneWidget);

      // Wait for the home page to load
      await tester.pumpAndSettle();

      // Tap on a post item to navigate to details
      final postItem = find.byType(PostCard).first;
      await tester.tap(postItem);
      await tester.pumpAndSettle();

      // Verify that the post details page is displayed
      expect(find.byType(PostDetailsPage), findsOneWidget);
    });

    testWidgets("Navigate to PostUserProfilePage", (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        MultiProvider(
          providers: dependencies,
          child: const MainApp(),
        ),
      );

      // Wait for the app to load
      await tester.pumpAndSettle();

      // Login screen because logget out
      expect(find.byType(LoginPage), findsOneWidget);

      // Find the email and password fields
      final emailField = find.byKey(const ValueKey("email-field"));
      final passwordField = find.byKey(const ValueKey("password-field"));

      // Enter valid credentials
      await tester.enterText(emailField, 'user.teste@gmail.com');
      await tester.enterText(passwordField, 'Teste@123');

      // Wait for the text fields to update
      await tester.pumpAndSettle();

      // Find the login button
      final loginButton = find.byKey(const ValueKey("login-button"));

      // Tap the login button
      await tester.tap(loginButton);

      // Wait for the login process to complete
      await tester.pumpAndSettle();

      // Verify that the login was successful and the home page is displayed
      expect(find.byType(HomePage), findsOneWidget);

      // Wait for the home page to load
      await tester.pumpAndSettle();

      // Tap on a post user avatar to navigate to PostUserProfilePage
      final userAvatar = find.byType(CircleAvatar).first;
      await tester.tap(userAvatar);
      await tester.pumpAndSettle();

      // Verify that the user profile page is displayed
      expect(find.byType(PostUserProfilePage), findsOneWidget);
    });

    testWidgets("Perform logout", (tester) async {
      // Load app widget.
      await tester.pumpWidget(
        MultiProvider(
          providers: dependencies,
          child: const MainApp(),
        ),
      );

      // Wait for the app to load
      await tester.pumpAndSettle();

      // Login screen because logget out
      expect(find.byType(LoginPage), findsOneWidget);

      // Find the email and password fields
      final emailField = find.byKey(const ValueKey("email-field"));
      final passwordField = find.byKey(const ValueKey("password-field"));

      // Enter valid credentials
      await tester.enterText(emailField, 'user.teste@gmail.com');
      await tester.enterText(passwordField, 'Teste@123');

      // Wait for the text fields to update
      await tester.pumpAndSettle();

      // Find the login button
      final loginButton = find.byKey(const ValueKey("login-button"));

      // Tap the login button
      await tester.tap(loginButton);

      // Wait for the login process to complete
      await tester.pumpAndSettle();

      // Verify that the login was successful and the home page is displayed
      expect(find.byType(HomePage), findsOneWidget);

      // Wait for the home page to load
      await tester.pumpAndSettle();

      // Tap on the logout button
      final logoutButton = find.byKey(const ValueKey("logout-button"));
      await tester.tap(logoutButton);
      await tester.pumpAndSettle();

      // Verify that the app navigates to the login page
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
