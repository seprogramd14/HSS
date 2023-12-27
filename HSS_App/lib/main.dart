import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'mypage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: LogIn(),
      title: 'HSS',
      routes: {
        '/LogIn': (context) => const LogIn(),
        '/SignUp': (context) => const SignUp(),
        '/Home': (context) => const MyAppPage(),
      },
    );
  }
}