import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  static const String routeName = '/details';

  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int movieId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(title: const Text('Movie Details')),
      body: Center(
        child: Text('Movie ID: $movieId', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
