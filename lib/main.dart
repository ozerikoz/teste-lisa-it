import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_bloc.dart';
import 'package:teste_lisa_it/core/blocs/observer/observer_bloc.dart';
import 'package:teste_lisa_it/core/dependencies.dart';
import 'package:teste_lisa_it/core/router/router.dart';
import 'package:teste_lisa_it/config/firebase_options.dart';
import 'package:teste_lisa_it/presentation/core/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Firebase
  await Firebase.initializeApp(
    name: "test-lisa-it",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Init Bloc Observer
  Bloc.observer = AppBlocObserver();

  runApp(
    MultiProvider(
      // Init app dependencies
      providers: dependencies,
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: context.read(),
        // Check auth status on app start
      )..add(AuthCheckEvent()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router(),
      ),
    );
  }
}
