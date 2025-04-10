import 'package:flutter/material.dart';
import 'package:teste_lisa_it/presentation/core/widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TesteLisaAppBar(title: "Feed de posts"),
      body: Container(),
    );
  }
}
