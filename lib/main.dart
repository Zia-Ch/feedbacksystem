import 'package:feedbacksystem/view/screens/auth/sign_up_screen.dart';
import 'package:feedbacksystem/view/screens/error/error_Screen.dart';
import 'package:feedbacksystem/view/screens/home/home_screen.dart';
import 'package:feedbacksystem/view/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'apis/auth_api.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeScreen();
              }
              return const SignUpScreen();
            },
            error: (error, st) => ErrorScreen(
              error: error.toString(),
            ),
            loading: () => const LoadingScreen(),
          ),
    );
  }
}
