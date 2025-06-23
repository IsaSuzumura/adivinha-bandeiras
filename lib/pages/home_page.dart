import 'package:flutter/material.dart';
import '../app/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adivinha a Bandeira')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.quiz);
          },
          child: const Text('Começar Jogo'),
        ),
      ),
    );
  }
}
