import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
      ),
      body: const Center(
        child: Text(
          'HomeScreen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
