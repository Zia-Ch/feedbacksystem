import 'package:feedbacksystem/view/screens/home/home_screen.dart';
import 'package:feedbacksystem/view/widgets/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'apis/auth_api.dart';
import 'view/screens/auth/sign_in_screen.dart';

//TODO: add name in user model
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
    //ref.watch(authApiProvider).signout();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feedback App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AsyncValueWidget(
        value: ref.watch(currentUserAccountProvider),
        data: (user) {
          if (user != null) {
            return const HomeScreen();
          }
          return const SignInScreen();
        },
      ),
    );
  }
}
