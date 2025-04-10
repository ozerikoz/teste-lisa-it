import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:teste_lisa_it/core/blocs/auth/auth_bloc.dart';
import 'package:teste_lisa_it/core/blocs/observer/observer_bloc.dart';
import 'package:teste_lisa_it/core/dependencies.dart';
import 'package:teste_lisa_it/core/router/router.dart';
import 'package:teste_lisa_it/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Firebase
  await Firebase.initializeApp(
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
      ),
      child: MaterialApp.router(
        routerConfig: router(),
      ),
    );
  }
}
